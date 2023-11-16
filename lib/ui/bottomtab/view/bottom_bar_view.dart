import 'package:csust_edu_system/common/versionchecker/viewmodel/version_checker_view_model.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/bottomtab/viewmodel/bottom_tab_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../arch/baseview/consumer_view.dart';
import '../../../ass/string_assets.dart';
import '../../../common/unreadmsg/viewmodel/unread_msg_view_model.dart';

/// 底部导航栏View
///
/// @author zzp
/// @since 2023/9/19
/// @version v1.8.8
class BottomBarView extends StatelessWidget {
  const BottomBarView(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      required this.forumSwitcher});

  /// 帖子功能开关
  final bool forumSwitcher;

  /// 当前选中页面index
  final int currentIndex;

  /// 点击回调
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return ConsumerView<VersionCheckerViewModel>(
        builder: (context, versionCheckerViewModel, _) =>
      ConsumerView<UnreadMsgViewModel>(
      onInit: (viewModel) {
        context.read<BottomTabViewModel>().showUnreadNotification(
          onFinish: () {
            context
                .readViewModel<VersionCheckerViewModel>()
                .checkoutVersion(isBegin: true);
          },
        );
        viewModel.getUnreadMsg();
      },
      builder: (context, unreadMsgViewModel, _) => BottomNavigationBar(
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              activeIcon: Icon(Icons.assignment),
              label: StringAssets.course),
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_work_outlined),
              activeIcon: Icon(Icons.home_work),
              label: StringAssets.campus),
          if (forumSwitcher)
            const BottomNavigationBarItem(
                icon: Icon(Icons.forum_outlined),
                activeIcon: Icon(Icons.forum),
                label: StringAssets.forum),
          BottomNavigationBarItem(
              icon: _getMineIcon(false, unreadMsgViewModel.model.hasUnreadMsg,versionCheckerViewModel.model.hasNewVersion),
              activeIcon:
                  _getMineIcon(true, unreadMsgViewModel.model.hasUnreadMsg,versionCheckerViewModel.model.hasNewVersion),
              label: StringAssets.mine)
        ],
      ),
      ),
    );
  }

  /// 「我的」icon
  ///
  /// [isActive] 是否被选中
  /// [hasUnreadMsg] 是否有未读消息
  /// [hasNewVersion] 是否有新版本
  Widget _getMineIcon(bool isActive, bool hasUnreadMsg, bool hasNewVersion) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Icon(
          isActive ? Icons.person : Icons.person_outline,
        ),
        if (hasUnreadMsg || hasNewVersion)
          const Icon(
            Icons.circle,
            color: Colors.red,
            size: 9,
          )
      ],
    );
  }
}
