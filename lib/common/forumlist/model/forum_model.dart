import '../jsonbean/forum_bean.dart';

/// 帖子Model
///
/// @author zzp
/// @since 2023/10/25
/// @version
abstract class ForumModel {
  ForumModel({required this.forumBean});

  /// 帖子
  final ForumBean forumBean;
}
