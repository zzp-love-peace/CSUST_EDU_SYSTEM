import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/message/viewmodel/message_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import '../../../common/lottie/none_lottie.dart';
import '../jsonbean/message_bean.dart';
import '../model/message_model.dart';
import '../view/msgItem_view.dart';

/// 消息通知Page
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.23
class MessagePage extends StatelessWidget{
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>MessageViewModel(model: MessageModel()))
    ],child: const MessageHome(),
    );
  }

}

class MessageHome extends StatelessWidget{
  const MessageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            StringAssets.myMessage,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            labelStyle: const TextStyle(fontSize: 16),
            tabs: tabList,
          ),
          actions: [
            TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.grey.withOpacity(0.2))),
                onPressed: () {
                  context.read<MessageViewModel>().setAllMsgRead();
                },
                child: const Text(
                  StringAssets.readAll,
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
        body: TabBarView(children: [
          ConsumerView<MessageViewModel>(


              builder: (context,viewModel,_){
            return EasyRefresh(
                header: MaterialHeader(),
                onRefresh: () async {
                  viewModel.getReadMsg();
                },
                child: viewModel.model.unReadMsgList.isNotEmpty ?
                ImplicitlyAnimatedList<Msg>(
                  items: viewModel.model.unReadMsgList,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  areItemsTheSame: (a, b) => a.id == b.id,
                  itemBuilder: (context, animation, item, index) {
                    return buildFadeWidgetVertical(MsgItemView(
                        msg: item,
                        isRead: true), animation);
                  },
                  removeItemBuilder: (context, animation, oldItem) {
                    return buildFadeWidgetVertical(MsgItemView(
                        msg: oldItem,
                        isRead: true), animation);
                  },
                ) : const NoneLottie(hint: StringAssets.messageEmpty)

              // AnimatedList\

              //     key: _listKey,
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     initialItemCount: _unreadMsgList.length,
              //     itemBuilder: (context, index, animation) {
              //       return buildFadeWidget(
              //           _MsgItemView(_unreadMsgList[index], false), animation);
              //     }),
            );
          }),
          ConsumerView<MessageViewModel>(builder: (context,viewModel,_){
            return EasyRefresh(
                header: MaterialHeader(),
                onRefresh: () async {
                  viewModel.getReadMsg();
                },
                child: viewModel.model.readMsgList.isNotEmpty ?
                ListView.builder(
                    itemCount: viewModel.model.readMsgList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return MsgItemView(
                          msg: viewModel.model.readMsgList[index],
                          isRead: true);
                    }) : const NoneLottie(hint: StringAssets.messageEmpty)
            );
          })
        ]),
      ),
    );

  }

}

Widget buildFadeWidgetVertical(
    Widget child,
    Animation<double> animation,
    ) {
  return SlideTransition(
      position:
      Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0))
          .animate(animation),
      child: FadeTransition(
          opacity: animation,
          child: SizeTransition(
              axis: Axis.vertical, sizeFactor: animation, child: child)));
}

Widget buildFadeWidgetHorizontal(
    Widget child,
    Animation<double> animation,
    ) {
  return SlideTransition(
      position:
      Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
          .animate(animation),
      child: FadeTransition(
          opacity: animation,
          child: SizeTransition(
              axis: Axis.horizontal, sizeFactor: animation, child: child)));
}