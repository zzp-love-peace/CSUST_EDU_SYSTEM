import 'package:csust_edu_system/ui/message/jsonbean/message_bean.dart';

/// 消息界面View model
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.25
class MessageModel {
  /// 未读消息list
  List<MsgBean> unReadMsgList = [];

  /// 已读消息list
  List<MsgBean> readMsgList = [];
}
