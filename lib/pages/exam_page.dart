import 'dart:convert';

import 'package:csust_edu_system/data/date_info.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/network/network.dart';
import 'package:csust_edu_system/provider/app_provider.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:csust_edu_system/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({Key? key}) : super(key: key);

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  List _examList = [];
  late final SharedPreferences prefs;
  String _term = DateInfo.nowTerm;
  int _lastClick = 0;

  @override
  void initState() {
    super.initState();
    _initPrefs();
    _queryExam(DateInfo.nowTerm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _examPageAppBar(), body: _examCenterLayout());
  }

  AppBar _examPageAppBar() {
    return AppBar(
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Container(
              color: Colors.white,
              height: 40,
              child: MyDatePicker(callBack: (term) {
                _queryExam(term);
                _term = term;
              }))),
      elevation: 0,
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              var now = DateTime.now().millisecondsSinceEpoch;
              if (now - _lastClick < 1500) return;
              _lastClick = now;
              _queryExam(_term);
              SmartDialog.showToast('', widget: const CustomToast('刷新成功'));
            },
            icon: const Icon(Icons.refresh, color: Colors.white))
      ],
      title: const Text(
        "考试",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _examCenterLayout() {
    return _examList.isNotEmpty
        ? ListView(
            children: _getExamItem(),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/no_message_exam.png'),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '暂无数据',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          );
  }

  List<Widget> _getExamItem() {
    List<Widget> result = [];
    for (var element in _examList) {
      List<String> d1 = element['startTime'].toString().split(' ');
      List<String> d2 = element['endTime'].toString().split(' ');
      String startTime = d1[1];
      String endTime = d2[1];
      List<String> date = d1[0].split('-');
      bool isToday = false;
      if (d1[0] == DateInfo.nowDate) isToday = true;
      result.add(Card(
          color: isToday ? Theme.of(context).primaryColor : Colors.white38,
          margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      '${date[0]}/',
                      style: TextStyle(
                          fontSize: 16,
                          color: isToday ? Colors.white : Colors.black),
                    ),
                    Text('${date[1]}/${date[2]}',
                        style: TextStyle(
                            fontSize: 16,
                            color: isToday ? Colors.white : Colors.black))
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      element['courseName'].toString().length > 12
                          ? element['courseName'].toString().substring(0, 12) +
                              "..."
                          : element['courseName'].toString(),
                      style: TextStyle(
                          fontSize: 16,
                          color: isToday ? Colors.white : Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text('$startTime-$endTime',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isToday ? Colors.white : Colors.black)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(element['address'],
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isToday ? Colors.white : Colors.black)),
                    ),
                  ],
                ),
              ],
            ),
          )));
    }
    result.add(const SizedBox(
      height: 50,
    ));
    return result;
  }

  _queryExam(String term) {
    // if (StuInfo.token.isEmpty && StuInfo.cookie.isEmpty) return;
    HttpManager().queryExam(StuInfo.token, StuInfo.cookie, term).then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          setState(() {
            _examList = value['data'];
            if (term == DateInfo.nowTerm) {
              _saveExam();
            }
          });
        } else if (value['code'] == 401 && DateInfo.nowTerm == term) {
          if (DateInfo.nowWeek != -1) {
            setState(() {
              _examList = json.decode(_initExam());
            });
          } else {
            setState(() {
              _examList = [];
              _saveExam();
            });
          }
        } else if (value['code'] == 501) {
          SmartDialog.showToast('', widget: CustomToast(value['msg']));
          setState(() {
            _examList = json.decode(_initExam());
          });
        } else {
          setState(() {
            _examList = [];
          });
        }
      } else {
        if (term != DateInfo.nowTerm) {
          SmartDialog.showToast('', widget: const CustomToast('获取考试信息异常'));
        } else {
          setState(() {
            _examList = json.decode(_initExam());
          });
        }
      }
    });
  }

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  _saveExam() async {
    prefs.setString("exam", jsonEncode(_examList));
  }

  _initExam() => prefs.getString("exam");
}
