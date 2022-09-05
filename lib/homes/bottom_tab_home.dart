import 'package:csust_edu_system/data/my_icons.dart';
import 'package:csust_edu_system/pages/course_page.dart';
import 'package:csust_edu_system/pages/forum_page.dart';
import 'package:csust_edu_system/homes/grade_home.dart';
import 'package:csust_edu_system/pages/mine_page.dart';
import 'package:csust_edu_system/pages/school_page.dart';
import 'package:csust_edu_system/provider/unread_msg_provider.dart';
import 'package:csust_edu_system/utils/course_util.dart';
import 'package:csust_edu_system/utils/my_util.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import '../data/stu_info.dart';
import '../network/network.dart';
import '../provider/theme_color_provider.dart';

class BottomTabHome extends StatefulWidget {

  const BottomTabHome({Key? key}) : super(key: key);

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
    _pages = [
      const CoursePage(),
      const SchoolPage(),
      const ForumPage(),
      const MinePage(),
    ];
    _getUnreadMsg();
    checkVersion(isBegin: true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          bottomNavigationBar: Consumer<UnreadMsgProvider>(builder: (context, appInfo, _)=> BottomNavigationBar(
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items:  [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_outlined),
                  activeIcon: Icon(Icons.assignment),
                  label: '课程表'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home_work_outlined),
                  activeIcon: Icon(Icons.home_work),
                  label: '校园'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.forum_outlined),
                  activeIcon: Icon(Icons.forum),
                  label: '圈子'),
              BottomNavigationBarItem(
                  // icon: Icon(
                  //   Icons.person_outline,
                  // ),
                  icon: Stack(
                    alignment: Alignment.topRight,
                    children:   [
                      const Icon(Icons.person_outline,),
                      if (appInfo.hasNewMsg)const Icon(Icons.circle, color: Colors.red, size: 9,)
                    ],
                  ),
                  activeIcon:
                  // Icon(Icons.person),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      const Icon(Icons.person,),
                      if (appInfo.hasNewMsg) const Icon(Icons.circle, color: Colors.red, size: 9,)
                    ],
                  ),
                  label: '我的'),
            ],
          ),
        ),),
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

  _getUnreadMsg() async {
    try {
      var value = await HttpManager().getUnreadMsg(StuInfo.token);
      if (value.isNotEmpty) {
        // print('_getUnreadMsg:$value');
        if (value['code'] == 200) {
          List data = value['data'];
          Provider.of<UnreadMsgProvider>(context, listen: false)
              .setHasNewMsg(data.isNotEmpty);
        } else {
          SmartDialog.compatible
              .showToast('', widget: CustomToast(value['msg']));
        }
      } else {
        SmartDialog.compatible
            .showToast('', widget: const CustomToast('出现异常了'));
      }
    } on Exception {
      SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了'));
    }
  }
}
