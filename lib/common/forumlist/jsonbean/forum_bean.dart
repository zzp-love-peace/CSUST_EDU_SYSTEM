import 'dart:convert';

import 'package:csust_edu_system/ass/key_assets.dart';

/// 帖子Bean类
///
/// @author zzp
/// @since 2023/9/28
/// @version v1.8.8
class ForumBean {
  ForumBean.fromJson(Map json)
      : id = json[KeyAssets.id],
        avatar = json[KeyAssets.userInfo][KeyAssets.avatar],
        username = json[KeyAssets.userInfo][KeyAssets.username],
        userId = json[KeyAssets.userInfo][KeyAssets.userId],
        content = json[KeyAssets.content],
        createTime = json[KeyAssets.createTime],
        likeNum = json[KeyAssets.likeNum],
        commentNum = json[KeyAssets.commentNum],
        isLike = json[KeyAssets.isLike],
        isEnshrine = json[KeyAssets.isEnshrine],
        images =
            (json[KeyAssets.images] as List).map((e) => e.toString()).toList(),
        isAdvertise = json[KeyAssets.advertise] ?? false;

  ForumBean.fromJsonString(String jsonString)
      : this.fromJson(jsonDecode(jsonString));

  /// 帖子id
  int id;

  /// 帖子头像url
  String avatar;

  /// 帖子用户名
  String username;

  /// 帖子用户id
  int userId;

  /// 帖子内容
  String content;

  /// 帖子点赞数
  int likeNum;

  /// 是否已点赞
  bool isLike;

  /// 是否已收藏
  bool isEnshrine;

  /// 评论数量
  int commentNum;

  /// 发帖时间
  String createTime;

  /// 帖子图片list
  List<String> images;

  /// 是否是广告帖子
  bool isAdvertise;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForumBean && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    return result;
  }

  @override
  String toString() {
    return ''''{id:$id, userinfo:{avatar:$avatar, username:$username, userId:$userId}, content:$content,
    createTime:$createTime, likeNum:$likeNum, commentNum:$commentNum, isLike:$isLike, isEnshrine:$isEnshrine,
    images:$images, isAdvertise:$isAdvertise}''';
  }
}