import 'package:csust_edu_system/ui/forumdetail/jsonbean/comment_bean.dart';
import 'package:flutter/cupertino.dart';

/// 评论Model
///
/// @author zzp
/// @since 2023/10/25
/// @version v1.8.8
class CommentItemModel {
  CommentItemModel({required this.commentBean});

  /// 是否处于展开态
  bool isExpanded = false;

  /// 回复
  final CommentBean commentBean;

  /// 内容输入控制器
  final contentController = TextEditingController();
}
