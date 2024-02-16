import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/common/functionswicher/viewmodel/function_switcher_view_model.dart';
import 'package:csust_edu_system/ui/bottomtab/model/bottom_tab_model.dart';
import 'package:csust_edu_system/ui/bottomtab/view/bottom_bar_view.dart';
import 'package:csust_edu_system/ui/bottomtab/viewmodel/bottom_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../course/page/course_page.dart';
import '../../forum/page/forum_page.dart';
import '../../mine/page/mine_page.dart';
import '../../school/page/school_page.dart';

/// 底部导航栏页面
///
/// @author zzp
/// @since 2023/9/19
/// @version v1.8.8
class BottomTabPage extends StatelessWidget {
  const BottomTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const CoursePage(),
      const SchoolPage(),
      const ForumPage(),
      const MinePage()
    ];
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) =>
              BottomTabViewModel(model: BottomTabModel(pages: pages))),
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
    return ConsumerView<FunctionSwitcherViewModel>(
      builder: (_, functionSwitcherViewModel, __) {
        var forumSwitcher =
            functionSwitcherViewModel.model.functionSwitcherBean.forum;
        return ConsumerView<BottomTabViewModel>(
          builder: (_, bottomTabViewModel, __) {
            if (bottomTabViewModel.model.pages.length > 3 && !forumSwitcher) {
              bottomTabViewModel.model.pages.removeAt(2);
            }
            return WillPopScope(
                child: Scaffold(
                    body: IndexedStack(
                      index: bottomTabViewModel.model.currentIndex,
                      children: bottomTabViewModel.model.pages,
                    ),
                    bottomNavigationBar: BottomBarView(
                        forumSwitcher: forumSwitcher,
                        currentIndex: bottomTabViewModel.model.currentIndex,
                        onTap: (index) {
                          bottomTabViewModel.setCurrentPageIndex(index);
                        })),
                onWillPop: bottomTabViewModel.isExit);
          },
        );
      },
    );
  }
}
