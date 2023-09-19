import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ui/bottomtab/model/bottom_tab_model.dart';
import 'package:csust_edu_system/ui/bottomtab/view/bottom_bar_view.dart';
import 'package:csust_edu_system/ui/bottomtab/viewmodel/bottom_tab_view_model.dart';
import 'package:csust_edu_system/ui/unreadmsg/model/unread_msg_model.dart';
import 'package:csust_edu_system/ui/unreadmsg/viewmodel/unread_msg_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../pages/course_page.dart';
import '../../../pages/forum_page.dart';
import '../../../pages/mine_page.dart';
import '../../../pages/school_page.dart';

/// 底部导航栏页面
///
/// @author zzp
/// @since 2023/9/19
/// @version v1.8.8
class BottomTabPage extends StatelessWidget {
  const BottomTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    var pageList = [
      const CoursePage(),
      const SchoolPage(),
      const ForumPage(),
      const MinePage()
    ];
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) =>
              BottomTabViewModel(model: BottomTabModel(pages: pageList))),
      ChangeNotifierProvider(
          create: (_) =>
              UnreadMsgViewModel(model: UnreadMsgModel())),
    ], child: const BottomTabHome());
  }
}

/// 底部导航栏页面Home
///
/// @author zzp
/// @since 2023/9/19
class BottomTabHome extends StatelessWidget {
  const BottomTabHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ConsumerView<BottomTabViewModel>(builder: (context, viewModel, _) {
      return WillPopScope(
          child: Scaffold(
              body: IndexedStack(
                index: viewModel.model.currentIndex,
                children: viewModel.model.pages,
              ),
              bottomNavigationBar: BottomBarView(
                  currentIndex: viewModel.model.currentIndex,
                  onTap: (index) {
                    viewModel.setCurrentPageIndex(index);
                  }
              )
          ),
          onWillPop: viewModel.isExit);
    });
  }
}
