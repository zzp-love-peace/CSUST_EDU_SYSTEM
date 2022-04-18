import 'dart:async';
import 'dart:convert';

import 'package:csust_edu_system/data/date_info.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/homes/login_home.dart';
import 'package:csust_edu_system/network/network.dart';
import 'package:csust_edu_system/utils/course_util.dart';
import 'package:csust_edu_system/utils/date_util.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_tab_home.dart';

class GuideHome extends StatefulWidget {
  const GuideHome({Key? key}) : super(key: key);

  @override
  State<GuideHome> createState() => _GuideHomeState();
}

class _GuideHomeState extends State<GuideHome> {
  late final SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _preWork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _guideText('博'),
                  _guideText('学'),
                  _guideText(' '),
                  _guideText('力'),
                  _guideText('行'),
                  const SizedBox(
                    height: 70,
                  )
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  _guideText('守'),
                  _guideText('正'),
                  _guideText(' '),
                  _guideText('拓'),
                  _guideText('新'),
                ],
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                'assets/images/logo.png',
                width: 60,
                height: 60,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              '长理教务',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 80,
        )
      ],
    ));
  }

  _preWork() async {
    //TODO:检查版本是否需要更新
    prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    var password = prefs.getString("password");
    var isRemember = prefs.getBool("isRemember") ?? false;
    if (username != null && password != null && isRemember) {
      var loginValue = await HttpManager().login(username, password);
      if (loginValue.isNotEmpty) {
        if (loginValue['code'] == 200) {
          StuInfo.initData(loginValue['data']);
          DateInfo.initData(loginValue['data']);
          try {
            var allCourseData = await HttpManager().getAllCourse(StuInfo.token,
                StuInfo.cookie, DateInfo.nowTerm, DateInfo.totalWeek);
            _saveData(allCourseData);
            Navigator.of(context).pushReplacement(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 1200),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animation, curve: Curves.fastOutSlowIn)),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BottomTabHome(allCourseData)));
          } on Exception {
            String list = await _initData();
            List data = json.decode(list);
            SmartDialog.showToast('', widget: const CustomToast('出现异常了'));
            Navigator.of(context).pushReplacement(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 1200),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animation, curve: Curves.fastOutSlowIn)),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BottomTabHome(data)));
          }
        } else {
          SmartDialog.showToast('', widget: CustomToast(loginValue['msg']));
          Navigator.of(context).pushReplacement(PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 800),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animation, curve: Curves.fastOutSlowIn)),
                  child: child,
                );
              },
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const LoginHome()));
        }
      } else {
        String list = await _initData();
        List data = json.decode(list);
        SmartDialog.showToast('', widget: const CustomToast('出现异常了'));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomTabHome(data)));
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginHome()));
    }
  }

  _saveData(List courseData) async {
    prefs.setString('name', StuInfo.name);
    prefs.setString('stuId', StuInfo.stuId);
    prefs.setString('college', StuInfo.college);
    prefs.setString('major', StuInfo.major);
    prefs.setString('className', StuInfo.className);
    prefs.setString('nowTerm', DateInfo.nowTerm);
    prefs.setString('nowDate', DateInfo.nowDate);
    prefs.setInt('nowWeek', DateInfo.nowWeek);
    prefs.setInt('totalWeek', DateInfo.totalWeek);
    prefs.setString('courseData', jsonEncode(courseData));
  }

  Future<String> _initData() async {
    StuInfo.token = "";
    StuInfo.cookie = "";
    StuInfo.name = prefs.getString('name') ?? '';
    StuInfo.stuId = prefs.getString('stuId') ?? '';
    StuInfo.college = prefs.getString('college') ?? '';
    StuInfo.major = prefs.getString('major') ?? '';
    StuInfo.className = prefs.getString('className') ?? '';
    DateInfo.nowTerm = prefs.getString('nowTerm') ?? '';
    DateInfo.totalWeek = prefs.getInt('totalWeek') ?? 0;
    int lastWeek = prefs.getInt('nowWeek') ?? -1;
    String lastDate = prefs.getString('nowDate') ?? '';
    DateInfo.nowDate = (DateTime.now().toString()).split(' ')[0];
    if (lastWeek > 0) {
      List lastList = DateUtil.splitDate(lastDate);
      final last = DateTime(lastList[0], lastList[1], lastList[2]);
      final diff = DateTime.now().difference(last).inDays;
      int weekOfLast = DateUtil.date2Week(lastDate);
      int weekOfToday = DateUtil.date2Week(DateInfo.nowDate);
      DateInfo.nowWeek = lastWeek + diff ~/ 7;
      if (weekOfToday < weekOfLast) DateInfo.nowWeek++;
    } else {
      DateInfo.nowWeek = -1;
    }
    String courseData = prefs.getString('courseData') ?? '';
    return courseData;
  }

  Text _guideText(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic));
  }
}
