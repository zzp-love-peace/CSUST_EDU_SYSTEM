import 'package:csust_edu_system/data/date_info.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/network/network.dart';
import 'package:csust_edu_system/utils/date_util.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:csust_edu_system/widgets/date_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({Key? key}) : super(key: key);

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  List _examList = [];

  @override
  void initState() {
    super.initState();
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
                _queryExam(DateInfo.nowTerm);
              }))),
      elevation: 0,
      centerTitle: true,
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
          color: isToday ? Colors.lightBlueAccent : Colors.white38,
          margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      '${date[0]}/',
                      style: TextStyle(
                          fontSize: 18,
                          color: isToday ? Colors.white : Colors.black),
                    ),
                    Text('${date[1]}/${date[2]}',
                        style: TextStyle(
                            fontSize: 18,
                            color: isToday ? Colors.white : Colors.black))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      element['courseName'],
                      style: TextStyle(
                          fontSize: 18,
                          color: isToday ? Colors.white : Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('$startTime-$endTime',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isToday ? Colors.white : Colors.black)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(element['address'],
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isToday ? Colors.white : Colors.black))
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
    if (StuInfo.token.isEmpty && StuInfo.cookie.isEmpty) return;
    HttpManager().queryExam(StuInfo.token, StuInfo.cookie, term).then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          setState(() {
            _examList = value['data'];
          });
        } else {
          setState(() {
            _examList = [];
          });
        }
      } else {
        SmartDialog.showToast('', widget: const CustomToast('获取考试信息异常'));
      }
    });
  }
}
