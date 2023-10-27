import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/common/forumlist/jsonbean/user_info_bean.dart';
import 'package:csust_edu_system/ui/forumdetail/jsonbean/reply_bean.dart';

import '../../../common/forumlist/jsonbean/real_info_bean.dart';

/// 评论Bean类
///
/// @author zzp
/// @since 2023/10/25
/// version v1.8.8
class CommentBean {
  CommentBean.fromJson(Map<String, dynamic> json)
      : id = json[KeyAssets.id],
        userInfo = UserInfoBean.fromJson(json[KeyAssets.userInfo]),
        realInfo = RealInfoBean.fromJson(json[KeyAssets.realInfo]),
        content = json[KeyAssets.content],
        createTime = json[KeyAssets.createTime],
        replyList = (json[KeyAssets.replyInfos] as List)
            .map((json) => ReplyBean.fromJson(json))
            .toList();

  /// 评论id
  int id;

  /// 评论者用户信息
  UserInfoBean userInfo;

  /// 发帖者实名信息
  RealInfoBean realInfo;

  /// 评论内容
  String content;

  /// 评论时间
  String createTime;

  /// 回复列表
  List<ReplyBean> replyList;
}
