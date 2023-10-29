import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/common/forumlist/jsonbean/user_info_bean.dart';

import '../../../common/forumlist/jsonbean/real_info_bean.dart';

/// 回复Bean类
///
/// @author zzp
/// @since 2023/10/25
/// version v1.8.8
class ReplyBean {
  ReplyBean.fromJson(Map<String, dynamic> json)
      : id = json[KeyAssets.id],
        userInfo = UserInfoBean.fromJson(json[KeyAssets.userInfo]),
        realInfo = RealInfoBean.fromJson(json[KeyAssets.realInfo]),
        content = json[KeyAssets.content],
        createTime = json[KeyAssets.createTime],
        commentId = json[KeyAssets.commentId],
        replyName = json[KeyAssets.replyName];

  /// 回复id
  int id;

  /// 发回复者的用户信息
  UserInfoBean userInfo;

  /// 发回复者的实名信息
  RealInfoBean realInfo;

  /// 回复内容
  String content;

  /// 回复创建时间
  String createTime;

  /// 回复所在的评论id
  int commentId;

  /// 被回复的用户名
  String? replyName;
}
