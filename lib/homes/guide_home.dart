import 'dart:async';
import 'dart:convert';

import 'package:csust_edu_system/data/date_info.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/homes/login_home.dart';
import 'package:csust_edu_system/network/http_manager.dart';
import 'package:csust_edu_system/provider/theme_color_provider.dart';
import 'package:csust_edu_system/utils/date_util.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/course_term_provider.dart';
import '../widgets/hint_dialog.dart';
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
    prefs = await SharedPreferences.getInstance();
    String colorKey = prefs.getString('color') ?? 'blue';
    // 设置初始化主题颜色
    Provider.of<ThemeColorProvider>(context, listen: false).setTheme(colorKey);
    var username = prefs.getString("username");
    var password = prefs.getString("password");
    var isRemember = prefs.getBool("isRemember") ?? false;
    if (username != null && password != null && isRemember) {
      var loginValue = await HttpManager().login(username, password);
      print('loginValue$loginValue');
      if (loginValue.isNotEmpty) {
        if (loginValue['code'] == 200) {
          //获取date相关数据
          StuInfo.token = loginValue['data']['token'];
          StuInfo.cookie = loginValue['data']['cookie'];
          var dateData =
              await HttpManager().getDateData(StuInfo.cookie, StuInfo.token);
          if (dateData.isNotEmpty) {
            if (dateData['code'] == 200) {
              DateInfo.initData(dateData['data']);
              Provider.of<CourseTermProvider>(context, listen: false)
                  .setNowTerm(DateInfo.nowTerm);
              print('dateData$dateData');
              var stuData =
                  await HttpManager().getStuInfo(StuInfo.cookie, StuInfo.token);
              if (stuData.isNotEmpty) {
                if (stuData['code'] == 200) {
                  print('studData$stuData');
                  StuInfo.initData(stuData['data']);
                } else {
                  SmartDialog.compatible
                      .showToast('', widget: CustomToast(stuData['msg']));
                  _loginWithException(false, true);
                }
              } else {
                SmartDialog.compatible
                    .showToast('', widget: const CustomToast('登录异常'));
                _loginWithException(false, true);
              }
            } else {
              SmartDialog.compatible
                  .showToast('', widget: CustomToast(dateData['msg']));
              _loginWithException(true, true);
            }
          } else {
            SmartDialog.compatible
                .showToast('', widget: const CustomToast('登录异常'));
            _loginWithException(true, true);
          }
          // _loginWithException(false, false);
          _saveData();
          // var allCourseData = await HttpManager().getAllCourse(StuInfo.token,
          //     StuInfo.cookie, DateInfo.nowTerm, DateInfo.totalWeek);
          // _saveData(courseData: allCourseData);
          Navigator.of(context).pushReplacement(PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return ScaleTransition(
                  scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animation, curve: Curves.fastOutSlowIn)),
                  child: child,
                );
              },
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const BottomTabHome()));
        } else if (loginValue['code'] == 501) {
          _loginWithException(true, true);
        } else if (loginValue['code'] == 502) {
          _loginWithException(true, true);
        } else {
          SmartDialog.compatible
              .showToast('', widget: CustomToast(loginValue['msg']));
          Navigator.of(context).pushReplacement(PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
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
        SmartDialog.compatible.showToast('', widget: const CustomToast('登录异常'));
        _loginWithException(true, true);
      }
    } else {
      Future.delayed(const Duration(milliseconds: 1800), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginHome()));
      });
    }
  }

  _saveData() {
    prefs.setString('name', StuInfo.name);
    prefs.setString('stuId', StuInfo.stuId);
    prefs.setString('college', StuInfo.college);
    prefs.setString('major', StuInfo.major);
    prefs.setString('className', StuInfo.className);
    prefs.setString('avatar', StuInfo.avatar);
    prefs.setString('nowTerm', DateInfo.nowTerm);
    prefs.setString('nowDate', DateInfo.nowDate);
    prefs.setInt('nowWeek', DateInfo.nowWeek);
    prefs.setInt('totalWeek', DateInfo.totalWeek);
    // if (courseData != null) {
    //   prefs.setString('courseData', jsonEncode(courseData));
    // }
  }

  _initData(bool isDate, bool isStu) {
    if (isDate) {
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
      Provider.of<CourseTermProvider>(context, listen: false)
          .setNowTerm(DateInfo.nowTerm);
    }
    if (isStu) {
      StuInfo.name = prefs.getString('name') ?? '';
      StuInfo.stuId = prefs.getString('stuId') ?? '';
      StuInfo.college = prefs.getString('college') ?? '';
      StuInfo.major = prefs.getString('major') ?? '';
      StuInfo.className = prefs.getString('className') ?? '';
      StuInfo.avatar = prefs.getString('avatar') ?? '';
    }
    // String courseData = '';
    // if (isCourse) {
    //   courseData = prefs.getString('courseData') ?? '';
    // }
    // return courseData;
  }

  Text _guideText(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic));
  }

  _loginWithException(bool isDate, bool isStu) async {
    _initData(isDate, isStu);
    // List data = [];
    // try {
    //    data = json.decode(list);
    // } on FormatException {
    //   // SmartDialog.compatible.show(
    //   //     widget: const HintDialog(
    //   //         title: '提示', subTitle: '教务系统异常且暂未保存课程表，请稍后再试'));
    //   SmartDialog.compatible.showToast('', widget: const CustomToast('获取课表出错了'));
    // }
    print("登录异常: isDate:$isDate  isStu:$isStu");
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animation, curve: Curves.fastOutSlowIn)),
              child: child,
            );
          },
          pageBuilder: (context, animation, secondaryAnimation) =>
              const BottomTabHome()));
    });
  }
}
