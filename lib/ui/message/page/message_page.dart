import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/ui/message/view/message_list_view.dart';
import 'package:csust_edu_system/ui/message/viewmodel/message_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/tab_list.dart';
import '../model/message_model.dart';

/// 消息通知Page
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.23
class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MessageViewModel(
            model: MessageModel(),
          ),
        ),
      ],
      child: const MessageHome(),
    );
  }
}

/// 消息通知Home
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.23
class MessageHome extends StatelessWidget {
  const MessageHome({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MessageViewModel>().injectContext(context);
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        appBar: CommonAppBar.create(
          StringAssets.myMessage,
          bottom: TabBar(
            labelColor: Colors.white,
            labelStyle: const TextStyle(fontSize: 16),
            tabs: tabList,
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.grey.withOpacity(0.2))),
              onPressed: () {
                context.read<MessageViewModel>().setAllMsgRead();
              },
              child: const Text(
                StringAssets.readAll,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            MessageListView(isReadList: false),
            MessageListView(isReadList: true),
          ],
        ),
      ),
    );
  }
}
