import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/url_assets.dart';

import '../../../common/unreadmsg/service/unread_msg_service.dart';
import '../../../util/typedef_util.dart';

/// 消息通知Service
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.23
class MessageService extends UnreadMsgService {
  /// 获得已读消息
  ///
  /// [onDataSuccess] 获取数据成功回调
  void getReadMsg({required OnDataSuccess<KeyList> onDataSuccess}) {
    get(UrlAssets.getReadMsg, onDataSuccess: onDataSuccess);
  }

  /// 设置某条消息已读
  ///
  /// [id] 消息id
  /// [type] 消息类型
  /// [onDataSuccess] 获取数据成功回调
  void setMsgRead(int id, int type,
      {required OnDataSuccess<KeyMap?> onDataSuccess}) {
    post(UrlAssets.setMsgRead,
        params: {KeyAssets.id: id, KeyAssets.type: type},
        onDataSuccess: onDataSuccess);
  }

  /// 设置全部消息已读
  ///
  /// [onDataSuccess] 获取数据成功回调
  void setAllMsgRead({required OnDataSuccess<KeyList> onDataSuccess}) {
    post(UrlAssets.setAllMsgRead, onDataSuccess: onDataSuccess);
  }

  /// 获得论坛info
  ///
  /// [onDataSuccess] 获取数据成功回调
  void getForumInfo(int id, {required OnDataSuccess<KeyMap> onDataSuccess}) {
    get(UrlAssets.getForumInfo,
        params: {KeyAssets.id: id}, onDataSuccess: onDataSuccess);
  }
}
