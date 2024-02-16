import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/common/dialog/hint_dialog.dart';
import 'package:csust_edu_system/data/app_info.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/advice/page/advice_page.dart';
import 'package:csust_edu_system/ui/mine/view/mine_head_image_container_view.dart';
import 'package:csust_edu_system/ui/mine/viewmodel/mine_head_container_view_model.dart';
import 'package:csust_edu_system/ui/notification/page/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../common/dialog/select_dialog.dart';
import '../../../common/functionswicher/viewmodel/function_switcher_view_model.dart';
import '../../../common/unreadmsg/viewmodel/unread_msg_view_model.dart';
import '../../../common/versionchecker/viewmodel/version_checker_view_model.dart';
import '../../../data/stu_info.dart';
import '../../login/page/login_page.dart';
import '../../message/page/message_page.dart';
import '../../mycollect/page/my_collect_page.dart';
import '../../myforum/page/my_forum_page.dart';
import '../../setting/page/setting_page.dart';
import '../model/mine_head_container_model.dart';

/// 我的页面
///
/// @author zzp
/// @since 2023/10/22
/// @version v1.8.8
class MinePage extends StatelessWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => MineHeadContainerViewModel(
              model: MineHeadContainerModel(
                  userName: StuInfo.username, avatar: StuInfo.avatar))),
    ], child: const MineHome());
  }
}

/// 我的页面Home
///
/// @author wk
/// @since 2023/11/27
/// @version v1.8.8
class MineHome extends StatelessWidget {
  const MineHome({super.key});

  @override
  Widget build(BuildContext context) {
    MineHeadContainerViewModel mineHeadContainerViewModel =
        context.readViewModel<MineHeadContainerViewModel>();
    return Scaffold(
      appBar: CommonAppBar.create(StringAssets.mine, actions: [
        IconButton(
          onPressed: () {
            SelectDialog(
              title: StringAssets.tips,
              subTitle: StringAssets.sureExitLogin,
              okCallback: () {
                context.pushReplacement(const LoginPage());
              },
            ).showDialog();
          },
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
        )
      ]),
      body: ListView(
        children: [
          const MineHeadImageContainerView(),
          ConsumerView<FunctionSwitcherViewModel>(
            builder: (ctx, viewModel, _) {
              return viewModel.model.functionSwitcherBean.forum
                  ? Card(
                      margin: const EdgeInsets.fromLTRB(12, 15, 12, 0),
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          _mineCardTile(
                            text: StringAssets.myForum,
                            icon: const Icon(
                              Icons.forum_outlined,
                              color: Colors.orange,
                            ),
                            onTap: () {
                              context.push(const MyForumPage());
                            },
                          ),
                          _mineCardTile(
                            text: StringAssets.myCollect,
                            icon: const Icon(
                              Icons.star_outline,
                              color: Colors.amber,
                            ),
                            onTap: () {
                              context.push(const MyCollectPage());
                            },
                          ),
                          _mineCardTile(
                            text: StringAssets.myMessage,
                            icon: const Icon(
                              Icons.message_outlined,
                              color: Colors.green,
                            ),
                            trailing: ConsumerView<UnreadMsgViewModel>(
                              builder: (context, appInfo, _) => Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  if (appInfo.model.hasUnreadMsg)
                                    const Padding(
                                      padding: EdgeInsets.only(right: 30),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        size: 9,
                                      ),
                                    )
                                ],
                              ),
                            ),
                            onTap: () {
                              context.push(const MessagePage());
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    )
                  : Container();
            },
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(12, 15, 12, 60),
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                _mineCardTile(
                  text: StringAssets.personalData,
                  icon: const Icon(
                    Icons.person_outline,
                    color: Colors.redAccent,
                  ),
                  onTap: mineHeadContainerViewModel.goToStuInfoPage,
                ),
                _mineCardTile(
                  text: StringAssets.systemNotice,
                  icon: const Icon(
                    Icons.circle_notifications_outlined,
                    color: Colors.cyan,
                  ),
                  onTap: () {
                    context.push(const NotificationPage());
                  },
                ),
                _mineCardTile(
                  text: StringAssets.accountAdvice,
                  icon: const Icon(
                    Icons.wallet,
                    color: Colors.amber,
                  ),
                  onTap: () {
                    context.push(const AdvicePage());
                  },
                ),
                _mineCardTile(
                  text: StringAssets.joinAppGroup,
                  icon: const Icon(
                    Icons.group_add_outlined,
                    color: Colors.cyan,
                  ),
                  onTap: () {
                    Clipboard.setData(const ClipboardData(text: '493018572'));
                    StringAssets.copyQQGroupNumSuccess.showToast();
                    const HintDialog(
                            title: StringAssets.tips,
                            subTitle:
                                '教务app交流1群：955731766\n教务app交流2群：493018572')
                        .showDialog();
                  },
                ),
                _mineCardTile(
                  text: StringAssets.checkoutUpdate,
                  icon: const Icon(
                    Icons.sync,
                    color: Colors.green,
                  ),
                  trailing: ConsumerView<VersionCheckerViewModel>(
                    builder: (context, appInfo, _) => Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        if (appInfo.model.hasNewVersion)
                          const Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 9,
                            ),
                          ),
                        const Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(AppInfo.version),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    context
                        .readViewModel<VersionCheckerViewModel>()
                        .checkoutVersion();
                  },
                ),
                _mineCardTile(
                  text: StringAssets.setting,
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    context.push(const SettingPage());
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 我的页面卡片内item
  ///
  /// [text] 文字
  /// [icon] 图标
  /// [onTap] 点击回调
  /// [trailing] 尾部图标
  Widget _mineCardTile(
      {required String text,
      required Icon icon,
      required Function onTap,
      Widget? trailing}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      height: 50,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            trailing ?? const SizedBox(),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
          ],
        ),
        onTap: () {
          onTap.call();
        },
      ),
    );
  }
}
