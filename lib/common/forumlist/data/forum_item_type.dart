import 'package:csust_edu_system/ass/string_assets.dart';

/// 帖子item类型
///
/// @author zzp
/// @since 2023/10/20
/// @version v1.8.8
enum ForumItemType {
  /// 圈子内的帖子
  tabForum,

  /// 我的收藏内的帖子
  collectForum,

  /// 我的发帖内的帖子
  myForum
}

/// 帖子item类型转hero动画tag
///
/// [type] 帖子item类型
String forumItemTypeToHeroTag(ForumItemType type) {
  String res;
  switch (type) {
    case ForumItemType.tabForum:
      res = StringAssets.forum;
      break;
    case ForumItemType.collectForum:
      res = StringAssets.myCollect;
      break;
    case ForumItemType.myForum:
      res = StringAssets.myForum;
      break;
  }
  return res;
}
