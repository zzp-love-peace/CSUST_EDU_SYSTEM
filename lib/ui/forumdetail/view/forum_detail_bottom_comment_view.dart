import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/forumdetail/viewmodel/forum_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

/// 帖子详情底部发表评论View
///
/// @author zzp
/// @since 2023/10/25
/// @version v1.8.8
class ForumDetailBottomCommentView extends StatelessWidget {
  const ForumDetailBottomCommentView({super.key});

  @override
  Widget build(BuildContext context) {
    var forumDetailViewModel = context.read<ForumDetailViewModel>();
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (forumDetailViewModel.model.forumBean.isAdvertise == false) {
                  forumDetailViewModel.showWriteCommentBottomSheet(
                    contentController:
                        forumDetailViewModel.model.commentController,
                    publishClickCallback: (content) {
                      forumDetailViewModel.postComment(content);
                    },
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 10, 5, 10),
                      child: Icon(
                        Icons.edit,
                        color: Colors.black45,
                      ),
                    ),
                    Text(
                      StringAssets.writeComment,
                      style: TextStyle(color: Colors.black45),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          LikeButton(
            likeBuilder: (bool isLiked) {
              return Icon(
                Icons.star,
                color: isLiked ? Colors.amberAccent : Colors.grey,
                size: 24,
              );
            },
            isLiked: forumDetailViewModel.model.forumBean.isEnshrine,
            likeCount: null,
            onTap: (bool isCollected) async {
              forumDetailViewModel.collectForum();
              return !isCollected;
            },
          ),
          const SizedBox(
            width: 15,
          ),
          LikeButton(
            likeCount: null,
            onTap: (bool isLiked) async {
              forumDetailViewModel.likeForum();
              return !isLiked;
            },
            size: 24,
            isLiked: forumDetailViewModel.model.forumBean.isLike,
          ),
        ],
      ),
    );
  }
}
