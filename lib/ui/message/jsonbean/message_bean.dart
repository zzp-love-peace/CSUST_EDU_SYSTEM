/// Msg类，这块可能后续会重构
/// 但这块没有做重构，就是直接从home中拉过来的
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.23

class Msg{
  late int id;
  late String avatar;
  late String username;
  late int userId;
  late String content;
  late String createTime;
  late int postId;
  late int type; // 0是评论 1是回复


  Msg.fromJson(Map value) {
  id = value['id'];
  avatar = value['userInfo']['avatar'];
  username = value['userInfo']['username'];
  userId = value['userInfo']['userId'];
  content = value['content'];
  createTime = value['createTime'];
  postId = value['postId'];
  type = value['type'];
  }

  @override
  bool operator ==(Object other) =>
  identical(this, other) ||
  other is Msg &&
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
