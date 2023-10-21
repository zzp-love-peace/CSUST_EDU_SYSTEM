import 'package:csust_edu_system/common/forumlist/model/forum_list_model.dart';

/// 标签帖子列表Model
///
/// @author zzp
/// @since 2023/10/19
/// @version v1.8.8
class ForumTabListModel extends ForumListModel {
  ForumTabListModel({required this.tabId});

  final int tabId;

  /// 当前页数
  int curPage = 1;

  /// 总页书
  int totalPages = 0;

  /// 一页的帖子数
  final int rows = 12;
}
