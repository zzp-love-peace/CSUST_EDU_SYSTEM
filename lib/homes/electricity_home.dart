import 'dart:convert';

import 'package:csust_edu_system/data/electricity_data.dart';
import 'package:csust_edu_system/network/network.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ElectricityHome extends StatefulWidget {
  const ElectricityHome({Key? key}) : super(key: key);

  @override
  State<ElectricityHome> createState() => _ElectricityHomeState();
}

class _ElectricityHomeState extends State<ElectricityHome> {
  final _roomController = TextEditingController();
  String _area = '';
  String _building = '';
  String _result = '';
  late final SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "查询电费",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              const Text(
                '校区',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Expanded(
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(60, 12, 0, 12),
                    child: Text(
                      _area,
                      style: TextStyle(color: _area.startsWith("点击选择")?Colors.black54:Colors.black, fontSize: 16),
                    ),
                  ),
                  onTap: () {
                    _showPicker('选择校区', ['金盆岭校区', '云塘校区'], (area) {
                      setState(() {
                        _area = area;
                      });
                    });
                  },
                ),
              )
            ],
          ),
          const Divider(
              thickness: 1, indent: 30, endIndent: 30, color: Colors.black12),
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              const Text(
                '宿舍楼',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Expanded(
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(42, 12, 0, 12),
                    child: Text(
                      _building,
                      style: TextStyle(color: _building.startsWith("点击选择")?Colors.black54:Colors.black, fontSize: 16),
                    ),
                  ),
                  onTap: () {
                    _showPicker('选择宿舍楼', Constant().getAllBuildingName(),
                        (building) {
                      setState(() {
                        _building = building;
                      });
                    });
                  },
                ),
              )
            ],
          ),
          const Divider(
              thickness: 1, indent: 30, endIndent: 30, color: Colors.black12),
         const SizedBox(height: 2,),
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              const Text(
                '房间号',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(
                width: 42,
              ),
              Expanded(
                  child: TextField(
                controller: _roomController,
                maxLines: 1,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                    hintText: '如：306，B123', hintStyle: TextStyle(fontSize: 16)),
              )),
              const SizedBox(
                width: 30,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Text(
              '提示：房间号，金村不分A区、B区则直接输入门牌号即可，云塘有A区、B区之分，则要加前缀，如B306，A504。',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: _queryButton(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Text(_result, style: const TextStyle(fontSize: 14, color: Colors.black),)
          ),
        ],
      ),
    );
  }

  _initData() async {
    prefs = await SharedPreferences.getInstance();
    final String? room = prefs.getString("room");
    setState(() {
      _area = prefs.getString("area") ?? "点击选择校区";
      _building = prefs.getString("building") ?? "点击选择宿舍楼";
      if (room != null && room.isNotEmpty) {
        _roomController.text = room;
      }
    });
  }

  _saveData() async {
    await prefs.setString("area", _area);
    await prefs.setString("building", _building);
    await prefs.setString("room", _roomController.text);
  }

  _showPicker(String title, List pickerData, Function(String campus) function) {
    Picker(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        confirmText: '确定',
        cancelText: '取消',
        adapter: PickerDataAdapter<String>(pickerdata: pickerData),
        changeToFirst: true,
        hideHeader: false,
        onConfirm: (Picker picker, List value) {
          String value =
              picker.adapter.text.substring(1, picker.adapter.text.length - 1);
          function(value);
        }).showModal(context);
  }

  ElevatedButton _queryButton() {
    return ElevatedButton(
      child: const SizedBox(
        child: Center(
          child: Text(
            "查询",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        width: double.infinity,
      ),
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 10, 0, 10)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
      onPressed: () {
        _doQuery(_area, _building, _roomController.text);
      },
    );
  }

  _doQuery(String area, String building, String roomId) async {
    if (area.isEmpty) {
      SmartDialog.compatible.showToast('', widget: const CustomToast('请选择校区'));
    } else if (building.isEmpty) {
      SmartDialog.compatible.showToast('', widget: const CustomToast('请选择宿舍楼'));
    } else if (roomId.isEmpty) {
      SmartDialog.compatible.showToast('', widget: const CustomToast('请输入房间号'));
    } else {
      var aid = (area == "云塘校区") ? "0030000000002501" : "0030000000002502";
      var jsonData = JsonData(QueryElectRoomInfo(
        "",
        "000001",
        aid,
        Area(area, area),
        Building(building, Constant().getBuildingId(building)),
        Floor("", ""),
        Room(roomId, roomId),
      )).toJson();
      var queryData = await HttpManager()
          .queryElectricity(json.encode(jsonData));
      if (queryData is Map) {
        SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了，查询失败'));
        return;
      }
      SmartDialog.compatible.showToast('', widget: const CustomToast('查询成功'));
      _saveData();
      var queryJsonMap = json.decode(queryData);
      var value = queryJsonMap["query_elec_roominfo"]["errmsg"];
      setState(() {
        _result = _area + _building + _roomController.text + value.toString().trim();
      });
    }
  }
}
