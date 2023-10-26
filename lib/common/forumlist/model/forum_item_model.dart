import 'package:csust_edu_system/common/forumlist/data/forum_item_type.dart';
import 'package:csust_edu_system/common/forumlist/model/forum_model.dart';

/// 帖子Item ViewModel
///
/// @author zzp
/// @since 2023/10/3
/// @version v1.8.8
class ForumItemModel extends ForumModel {
  ForumItemModel({required this.type, required super.forumBean});

  /// 帖子类型
  final ForumItemType type;
}
