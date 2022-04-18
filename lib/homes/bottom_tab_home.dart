import 'package:csust_edu_system/pages/course_page.dart';
import 'package:csust_edu_system/pages/exam_page.dart';
import 'package:csust_edu_system/pages/grade_page.dart';
import 'package:csust_edu_system/pages/mine_page.dart';
import 'package:csust_edu_system/utils/course_util.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class BottomTabHome extends StatefulWidget {
  final List _courseData;

  const BottomTabHome(this._courseData, {Key? key}) : super(key: key);

  @override
  State<BottomTabHome> createState() => _BottomTabHomeState();
}

class _BottomTabHomeState extends State<BottomTabHome> {
  int _currentIndex = 0;
  late final List<Widget> _pages;
  DateTime? _lastTime;

  @override
  void initState() {
    super.initState();
    // 修改完数据再传参
    List changed = CourseUtil.changeCourseDataList(widget._courseData);
    _pages = [
      CoursePage(changed),
      const GradePage(),
      const ExamPage(),
      const MinePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            body: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
            bottomNavigationBar: FancyBottomNavigation(
                onTabChangedListener: (position) {
                  setState(() {
                    _currentIndex = position;
                  });
                },
                tabs: [
                  TabData(
                    iconData: Icons.assignment,
                    title: "课程表",
                  ),
                  TabData(iconData: Icons.grading, title: "成绩"),
                  TabData(iconData: Icons.quiz, title: "考试"),
                  TabData(iconData: Icons.person, title: "我的")
                ],
                textColor: Colors.black.withOpacity(0.7))),
        onWillPop: _isExit);
  }

  Future<bool> _isExit() {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime!) >
            const Duration(milliseconds: 2500)) {
      _lastTime = DateTime.now();
      SmartDialog.showToast('', widget: const CustomToast('再次点击退出应用'));
      return Future.value(false);
    }
    return Future.value(true);
  }
}
