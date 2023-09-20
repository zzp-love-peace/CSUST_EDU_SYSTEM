import 'package:csust_edu_system/data/date_info.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/network/http_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';

typedef DateCallBack = void Function(String term);

class MyDatePicker extends StatefulWidget {

  final DateCallBack callBack;

  const MyDatePicker({Key? key, required this.callBack}) : super(key: key);

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> with AutomaticKeepAliveClientMixin{

  String _nowTerm = DateInfo.nowTerm;
  var _index = [0];
  List _allTerm = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    HttpManager().getAllSemester(StuInfo.cookie, StuInfo.token).then((value) {
      if (value.isNotEmpty) {
        print('value$value');
        if (value['code'] == 200) {
          print(value);
          setState(() {
            _allTerm = value['data'];
            if(DateInfo.nowTerm.isEmpty){
              DateInfo.nowTerm=_allTerm[_allTerm.length-2];
              _nowTerm= DateInfo.nowTerm;
            }
            _index = [_allTerm.indexOf(DateInfo.nowTerm)];
          });
        } else {
          if (kDebugMode) {
            print('获取所有学期出错了');
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          const SizedBox(width: 15,),
          const Icon(Icons.date_range,),
          const SizedBox(width: 5,),
          Text(_nowTerm, style: const TextStyle(fontSize: 17),),
          const SizedBox(width: 5,),
          const Icon(Icons.arrow_drop_down)
        ],
      ),
      onTap: () {
        if (StuInfo.token.isEmpty&&StuInfo.cookie.isEmpty) return;
        Picker(
            title: const Text('选择学期', style: TextStyle(fontSize: 18, color: Colors.black),),
            confirmText: '确定',
            cancelText: '取消',
            selecteds: _index,
            adapter: PickerDataAdapter<String>(pickerData: _allTerm),
            changeToFirst: true,
            hideHeader: false,
            onConfirm: (Picker picker, List value) {
              setState(() {
                _nowTerm = picker.adapter.text.substring(1, picker.adapter.text.length-1);
                _index = [value[0]];
                widget.callBack(_nowTerm);
              });
            }
        ).showModal(context); //_scaffoldKey.currentState);
      },
    );
  }
}
