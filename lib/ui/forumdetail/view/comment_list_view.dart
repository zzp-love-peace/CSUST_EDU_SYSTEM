import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:csust_edu_system/arch/baseview/seletor_view.dart';
import 'package:csust_edu_system/ui/forumdetail/view/comment_item_view.dart';
import 'package:csust_edu_system/ui/forumdetail/viewmodel/forum_detail_view_model.dart';
import 'package:flutter/material.dart';

import '../../../ass/string_assets.dart';
import '../../../common/lottie/none_lottie.dart';
import '../../../util/widget_util.dart';
import '../jsonbean/comment_bean.dart';

/// 帖子详情内评论列表View
///
/// @author zzp
/// @since 2023/10/25
/// version v1.8.8
class CommentListView extends StatelessWidget {
  const CommentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectorView<ForumDetailViewModel, List<CommentBean>>(
      selector: (ctx, viewModel) => viewModel.model.commentList,
      onInit: (viewModel) {
        viewModel.getForumDetail();
      },
      onDispose: (viewModel) {
        viewModel.model.commentController.dispose();
      },
      builder: (ctx, commentList, _) {
        return Column(
          children: [
            ImplicitlyAnimatedList<CommentBean>(
              items: commentList,
              shrinkWrap: true,
              updateDuration: const Duration(milliseconds: 300),
              insertDuration: const Duration(milliseconds: 300),
              physics: const NeverScrollableScrollPhysics(),
              areItemsTheSame: (a, b) => a.id == b.id,
              itemBuilder: (context, animation, item, index) {
                return WidgetUtil.buildFadeWidgetVertical(
                    CommentItemView(commentBean: item), animation);
              },
              removeItemBuilder: (context, animation, oldItem) {
                return WidgetUtil.buildFadeWidgetVertical(
                    CommentItemView(commentBean: oldItem), animation);
              },
            ),
            if (commentList.isEmpty) const NoneLottie(hint: StringAssets.nobody)
          ],
        );
      },
    );
  }
}
