import 'package:flutter/material.dart';

import '../../../arch/baseview/consumer_view.dart';
import '../../../ass/string_assets.dart';
import '../../../common/unreadmsg/viewmodel/unread_msg_view_model.dart';

/// 底部导航栏View
///
/// @author zzp
/// @since 2023/9/19
/// @version v1.8.8
class BottomBarView extends StatelessWidget {
  const BottomBarView({super.key, required this.currentIndex, required this.onTap});

  /// 当前选中页面index
  final int currentIndex;
  /// 点击回调
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return ConsumerView<UnreadMsgViewModel>(
      onInit: (viewModel) {
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
                  const BottomNavigationBarItem(
                      icon: Icon(Icons.forum_outlined),
                      activeIcon: Icon(Icons.forum),
                      label: StringAssets.forum),
                  BottomNavigationBarItem(
                      icon: _getMineIcon(
                          false, unreadMsgViewModel.model.hasUnreadMsg),
                      activeIcon: _getMineIcon(true, unreadMsgViewModel.model.hasUnreadMsg),
              label: StringAssets.mine)
        ]
      )
    );
  }

  /// 「我的」icon
  ///
  /// [isActive] 是否被选中
  /// [hasUnreadMsg] 是否有未读消息
  Widget _getMineIcon(bool isActive, bool hasUnreadMsg) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Icon(
          isActive ? Icons.person :Icons.person_outline,
        ),
        if (hasUnreadMsg)
          const Icon(
            Icons.circle,
            color: Colors.red,
            size: 9,
          )
      ]
    );
  }
}
