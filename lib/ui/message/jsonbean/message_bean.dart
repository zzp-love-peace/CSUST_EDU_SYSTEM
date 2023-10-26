import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/common/forumlist/jsonbean/user_info_bean.dart';

/// MsgBean类
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.23

class MsgBean {
  /// 消息id
  int id;

  /// 消息发送者用户信息
  UserInfoBean userInfo;

  /// 消息内容
  String content;

  /// 消息创建时间
  String createTime;

  /// 消息对应的帖子id
  int postId;

  /// 消息类别: 0是评论 1是回复
  int type;

  MsgBean.fromJson(Map<String, dynamic> json)
      : id = json[KeyAssets.id],
        userInfo = UserInfoBean.fromJson(json[KeyAssets.userInfo]),
        content = json[KeyAssets.content],
        createTime = json[KeyAssets.createTime],
        postId = json[KeyAssets.postId],
        type = json[KeyAssets.type];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MsgBean &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userInfo == other.userInfo &&
          content == other.content &&
          createTime == other.createTime &&
          postId == other.postId &&
          type == other.type;

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + userInfo.hashCode;
    result = 37 * result + content.hashCode;
    result = 37 * result + createTime.hashCode;
    result = 37 * result + postId.hashCode;
    result = 37 * result + type.hashCode;
    return result;
  }
}
