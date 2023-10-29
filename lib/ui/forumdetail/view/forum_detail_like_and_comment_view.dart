import 'package:csust_edu_system/arch/baseview/seletor_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/forumdetail/viewmodel/forum_detail_view_model.dart';
import 'package:flutter/material.dart';

/// 帖子详情内点赞和评论View
///
/// @author zzp
/// @since 2023/10/25
/// @version v1.8.8
class ForumDetailLikeAndCommentView extends StatelessWidget {
  const ForumDetailLikeAndCommentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.message_outlined,
                  color: Colors.black54,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(StringAssets.comment),
                const SizedBox(
                  width: 5,
                ),
                SelectorView<ForumDetailViewModel, int>(
                  selector: (ctx, viewModel) =>
                      viewModel.model.forumBean.commentNum,
                  builder: (ctx, commentNum, _) => Text(commentNum.toString()),
                ),
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.thumb_up_outlined,
                  color: Colors.black54,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(StringAssets.like),
                const SizedBox(
                  width: 5,
                ),
                SelectorView<ForumDetailViewModel, int>(
                  selector: (ctx, viewModel) =>
                      viewModel.model.forumBean.likeNum,
                  builder: (ctx, likeNum, _) => Text(likeNum.toString()),
                ),
              ],
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
