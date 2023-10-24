import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../viewmodel/forum_item_view_model.dart';

/// 帖子控制View（收藏 评论 点赞）
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class ForumControlView extends StatelessWidget {
  const ForumControlView({super.key});

  @override
  Widget build(BuildContext context) {
    return ConsumerView<ForumItemViewModel>(
      builder: (ctx, viewModel, _) {
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: LikeButton(
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.star,
                    color: isLiked ? Colors.amberAccent : Colors.grey,
                    size: 24,
                  );
                },
                isLiked: viewModel.model.forumBean.isEnshrine,
                likeCount: null,
                onTap: (bool isCollected) async {
                  viewModel.collectForum();
                  return !isCollected;
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                onTap: () {
                  viewModel.navigatorToDetailHome();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.comment, size: 24, color: Colors.grey),
                      if (viewModel.model.forumBean.commentNum > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            viewModel.model.forumBean.commentNum.toString(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: LikeButton(
                likeCount: viewModel.model.forumBean.likeNum > 0
                    ? viewModel.model.forumBean.likeNum
                    : null,
                onTap: (bool isLiked) async {
                  viewModel.likeForum();
                  return !isLiked;
                },
                size: 24,
                isLiked: viewModel.model.forumBean.isLike,
              ),
            ),
          ],
        );
      },
    );
  }
}
