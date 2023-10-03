import 'package:csust_edu_system/ass/key_assets.dart';

/// MsgBean类
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.23

class MsgBean {
  /// 消息id
  int id;

  /// 消息发送者头像
  String avatar;

  /// 消息发送者用户名
  String username;

  /// 消息发送者用户id
  int userId;

  /// 消息内容
  String content;

  /// 消息创建时间
  String createTime;

  /// 消息对应的帖子id
  int postId;

  /// 消息类别: 0是评论 1是回复
  int type;

  MsgBean.fromJson(Map value)
      : id = value[KeyAssets.id],
        avatar = value[KeyAssets.userInfo][KeyAssets.avatar],
        username = value[KeyAssets.userInfo][KeyAssets.username],
        userId = value[KeyAssets.userInfo][KeyAssets.userId],
        content = value[KeyAssets.content],
        createTime = value[KeyAssets.createTime],
        postId = value[KeyAssets.postId],
        type = value[KeyAssets.type];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MsgBean &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          avatar == other.avatar &&
          username == other.username &&
          userId == other.userId &&
          content == other.content &&
          createTime == other.createTime &&
          postId == other.postId &&
          type == other.type;

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + avatar.hashCode;
    result = 37 * result + username.hashCode;
    result = 37 * result + userId.hashCode;
    result = 37 * result + content.hashCode;
    result = 37 * result + createTime.hashCode;
    result = 37 * result + postId.hashCode;
    result = 37 * result + type.hashCode;
    return result;
  }
}
