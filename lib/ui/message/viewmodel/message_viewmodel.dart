import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ui/message/model/message_model.dart';
import 'package:csust_edu_system/ui/message/service/message_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../homes/detail_home.dart';
import '../../../provider/unread_msg_provider.dart';
import '../../../widgets/forum_item.dart';
import '../jsonbean/message_bean.dart';

/// 消息界面View model
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.23
class MessageViewModel extends BaseViewModel<MessageModel, MessageService> {
  MessageViewModel({required super.model});


  /// 获得已读消息
  /// 这个函数在未来可能因为论坛部分的重构而删除，请不要在其他地方引用
  setMsgRead(Msg message) {
    service?.setMsgRead(message.id, message.type, onDataSuccess: (data, msg) {
      model.unReadMsgList.add(message);
      model.readMsgList.add(message);
      if (model.unReadMsgList.isEmpty) {
        Provider.of<UnreadMsgProvider>(context, listen: false)
            .setHasNewMsg(model.unReadMsgList.isNotEmpty);
      }
      notifyListeners();
    });
  }

  /// 获得全部已读消息
  /// 这个函数在未来可能因为论坛部分的重构而删除，请不要在其他地方引用
  setAllMsgRead() {
    service?.setAllMsgRead(onDataSuccess: (data, msg) {
      model.readMsgList.addAll(model.unReadMsgList);
      model.unReadMsgList.clear();
    });
    notifyListeners();
  }
  /// 获得全部未读消息
  getUnreadMsg() {
    service?.getUnreadMsg(onDataSuccess: (data, msg) {
      for (var msgData in data) {
        var message = Msg.fromJson(msgData);
        if (!model.unReadMsgList.contains(message)) {
          model.unReadMsgList.add(message);
        }
      }
    });
    notifyListeners();
  }
  /// 获得全部已读消息
  getReadMsg() {
    service?.getReadMsg(onDataSuccess: (data, msg) {
      model.readMsgList = data.map((e) => Msg.fromJson(e)).toList();
    });
    notifyListeners();
  }
  ///从接受的消息推送到详情页
  ///这个部分需要重构，所以先保持大部分原本逻辑
  pushDetail(Msg message,bool isRead){
    service?.getForumInfo(message.postId, onDataSuccess: (data,msg){
      var forum = Forum.fromJson(data['indexPost']);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailHome(
            forum: forum,
            stateCallback: (isLike, isCollect) {
              if (!isRead) {
                setMsgRead(message);
              }
            },
          )));
    });
    notifyListeners();
  }
}

/// 这个tab类是给page中的tab用的
final List<Widget> tabList = [
  const Tab(
    text: '未读',
  ),
  const Tab(
    text: '已读',
  )
];

