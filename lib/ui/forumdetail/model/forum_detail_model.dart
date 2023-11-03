import 'package:csust_edu_system/common/forumlist/data/forum_item_type.dart';
import 'package:csust_edu_system/common/forumlist/model/forum_model.dart';
import 'package:flutter/cupertino.dart';

import '../jsonbean/comment_bean.dart';

/// 帖子详情Model
///
/// @author zzp
/// @since 2023/10/23
/// @version v1.8.8
class ForumDetailModel extends ForumModel {
  ForumDetailModel({required super.forumBean, required this.type});

  /// 帖子类型
  final ForumItemType type;

  /// 评论列表
  List<CommentBean> commentList = [];

  /// 评论输入控制器
  final commentController = TextEditingController();
}
