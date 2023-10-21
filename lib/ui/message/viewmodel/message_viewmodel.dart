import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/common/unreadmsg/viewmodel/unread_msg_view_model.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ext/list_extension.dart';
import 'package:csust_edu_system/ui/message/model/message_model.dart';
import 'package:csust_edu_system/ui/message/service/message_service.dart';
import 'package:provider/provider.dart';

import '../../../common/forumlist/jsonbean/forum_bean.dart';
import '../../../homes/detail_home.dart';
import '../jsonbean/message_bean.dart';

/// 消息界面View model
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.23
class MessageViewModel extends BaseViewModel<MessageModel, MessageService> {
  MessageViewModel({required super.model});

  @override
  MessageService? createService() => MessageService();

  /// 设置某条消息已读
  /// 这个函数在未来可能因为论坛部分的重构而删除，请不要在其他地方引用
  ///
  /// [message] 消息
  void setMsgRead(MsgBean message) {
    service?.setMsgRead(
      message.id,
      message.type,
      onDataSuccess: (data, msg) {
        model.unReadMsgList = model.unReadMsgList.removeCanNotify(message);
        model.readMsgList = model.readMsgList.insertCanNotify(message, 0);
        if (model.unReadMsgList.isEmpty) {
          context.read<UnreadMsgViewModel>().setHasUnreadMsg(false);
        }
        notifyListeners();
      },
    );
  }

  /// 设置全部未读消息已读
  void setAllMsgRead() {
    if (model.unReadMsgList.isNotEmpty) {
      service?.setAllMsgRead(
        onDataSuccess: (data, msg) {
          model.readMsgList =
              model.readMsgList.addAllCanNotify(model.unReadMsgList);
          model.unReadMsgList = model.unReadMsgList.clearCanNotify();
          notifyListeners();
        },
      );
    }
  }

  /// 获得全部未读消息
  void getUnreadMsg() {
    service?.getUnreadMsg(
      onDataSuccess: (data, msg) {
        List<MsgBean> msgList = [];
        for (var msgData in data) {
          var message = MsgBean.fromJson(msgData);
          if (!model.unReadMsgList.contains(message)) {
            msgList.add(message);
          }
        }
        model.unReadMsgList = msgList;
        notifyListeners();
      },
    );
  }

  /// 获得全部已读消息
  void getReadMsg() {
    service?.getReadMsg(
      onDataSuccess: (data, msg) {
        model.readMsgList = data.map((json) => MsgBean.fromJson(json)).toList();
        notifyListeners();
      },
    );
  }

  ///从接受的消息推送到详情页
  ///这个部分需要重构，所以先保持大部分原本逻辑
  ///
  /// [message] 消息
  /// [isRead] 是否已读
  void pushDetail(MsgBean message, bool isRead) {
    service?.getForumInfo(
      message.postId,
      onDataSuccess: (data, msg) {
        var forum = ForumBean.fromJson(data[KeyAssets.indexPost]);
        context.push(
          DetailHome(
            forum: forum,
            stateCallback: (isLike, isCollect) {
              if (!isRead) {
                setMsgRead(message);
              }
            },
          ),
        );
      },
    );
  }
}
