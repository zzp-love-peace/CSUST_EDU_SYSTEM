import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:csust_edu_system/ui/forumdetail/view/reply_item_view.dart';
import 'package:flutter/material.dart';

import '../../../arch/baseview/consumer_view.dart';
import '../../../ass/string_assets.dart';
import '../../../util/widget_util.dart';
import '../jsonbean/reply_bean.dart';
import '../viewmodel/comment_item_view_model.dart';

/// 帖子详情内回复列表View
///
/// @author zzp
/// @since 2023/10/26
/// version v1.8.8
class ReplyListView extends StatelessWidget {
  const ReplyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ConsumerView<CommentItemViewModel>(
      onDispose: (viewModel) {
        viewModel.model.contentController.dispose();
      },
      builder: (ctx, viewModel, _) {
        return Column(
          children: [
            ImplicitlyAnimatedList<ReplyBean>(
              items: viewModel.model.isExpanded
                  ? viewModel.model.commentBean.replyList
                  : [],
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              areItemsTheSame: (a, b) => a.id == b.id,
              itemBuilder: (context, animation, item, index) {
                return WidgetUtil.buildFadeWidgetVertical(
                    ReplyItemView(replyBean: item), animation);
              },
              removeItemBuilder: (context, animation, oldItem) {
                return WidgetUtil.buildFadeWidgetVertical(
                    ReplyItemView(replyBean: oldItem), animation);
              },
            ),
            if (viewModel.model.commentBean.replyList.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 2),
                child: GestureDetector(
                  onTap: () {
                    viewModel.reverseExpandedState();
                  },
                  child: Row(
                    children: [
                      Text(
                        viewModel.model.isExpanded
                            ? StringAssets.dropReply
                            : StringAssets.expandReply,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      viewModel.model.isExpanded
                          ? const Icon(Icons.arrow_drop_up)
                          : const Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
