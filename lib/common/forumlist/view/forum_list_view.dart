import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/forumlist/data/forum_item_type.dart';
import 'package:flutter/material.dart';

import '../../../util/widget_util.dart';
import '../../lottie/none_lottie.dart';
import '../jsonbean/forum_bean.dart';
import 'forum_item_view.dart';

/// 帖子列表View
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class ForumListView extends StatelessWidget {
  const ForumListView(
      {super.key, required this.forumList, required this.forumItemType});

  /// 帖子item类型
  final ForumItemType forumItemType;

  /// 帖子list
  final List<ForumBean> forumList;

  @override
  Widget build(BuildContext context) {
    if (forumList.isNotEmpty) {
      return ImplicitlyAnimatedList<ForumBean>(
        items: forumList,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        areItemsTheSame: (a, b) => a.id == b.id,
        itemBuilder: (context, animation, item, index) {
          return WidgetUtil.buildFadeWidgetVertical(
              ForumItemView(forum: item, type: forumItemType), animation);
        },
        removeItemBuilder: (context, animation, oldItem) {
          return WidgetUtil.buildFadeWidgetVertical(
              ForumItemView(forum: oldItem, type: forumItemType), animation);
        },
      );
    } else {
      return const NoneLottie(hint: StringAssets.messageEmpty);
    }
  }
}
