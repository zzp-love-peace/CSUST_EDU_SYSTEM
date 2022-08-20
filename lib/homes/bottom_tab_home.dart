import 'package:csust_edu_system/data/my_icons.dart';
import 'package:csust_edu_system/pages/course_page.dart';
import 'package:csust_edu_system/pages/forum_page.dart';
import 'package:csust_edu_system/homes/grade_home.dart';
import 'package:csust_edu_system/pages/mine_page.dart';
import 'package:csust_edu_system/pages/school_page.dart';
import 'package:csust_edu_system/utils/course_util.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
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
      // const GradePage(),
      // const ExamPage(),
      const SchoolPage(),
      const ForumPage(),
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
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_outlined),
                  activeIcon: Icon(Icons.assignment),
                  label: '课程表'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_work_outlined),
                  activeIcon: Icon(Icons.home_work),
                  label: '校园'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.forum_outlined),
                  activeIcon: Icon(Icons.forum),
                  label: '圈子'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outline,
                  ),
                  // Stack(
                  //   alignment: Alignment.topRight,
                  //   children: [
                  //     Icon(Icons.person_outline,),
                  //     // Icon(Icons.circle, color: Colors.red, size: 9,)
                  //   ],
                  // ),
                  activeIcon: Icon(Icons.person),
                  // Stack(
                  //   alignment: Alignment.topRight,
                  //   children: [
                  //     Icon(Icons.person,),
                  //     // Icon(Icons.circle, color: Colors.red, size: 9,)
                  //   ],
                  // ),
                  label: '我的'),
            ],
          ),
        ),
        onWillPop: _isExit);
  }

  Future<bool> _isExit() {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime!) >
            const Duration(milliseconds: 2500)) {
      _lastTime = DateTime.now();
      SmartDialog.compatible.showToast('', widget: const CustomToast('再次点击退出应用'));
      return Future.value(false);
    }
    return Future.value(true);
  }
}
