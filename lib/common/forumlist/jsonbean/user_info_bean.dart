import 'package:csust_edu_system/ass/key_assets.dart';

/// 用户信息Bean类
///
/// @author zzp
/// @since 2023/10/25
/// @version v1.8.8
class UserInfoBean {
  UserInfoBean.fromJson(Map<String, dynamic> json)
      : avatar = json[KeyAssets.avatar],
        username = json[KeyAssets.username],
        userId = json[KeyAssets.userId];

  /// 头像url
  String avatar;

  /// 用户名
  String username;

  /// 用户id
  int userId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoBean &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          username == other.username &&
          avatar == other.avatar;

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + userId.hashCode;
    result = 37 * result + username.hashCode;
    result = 37 * result + avatar.hashCode;
    return result;
  }

  @override
  String toString() {
    return '{username:$username, userId:$userId, avatar:$avatar}';
  }
}
