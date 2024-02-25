import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/cachedimage/data/cached_image_type.dart';
import 'package:csust_edu_system/common/cachedimage/view/cached_image.dart';
import 'package:csust_edu_system/ui/forumdetail/jsonbean/reply_bean.dart';
import 'package:csust_edu_system/ui/forumdetail/viewmodel/comment_item_view_model.dart';
import 'package:csust_edu_system/ui/forumdetail/viewmodel/forum_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/stu_info.dart';
import 'comment_and_reply_control_dialog.dart';

/// 回复item
///
/// @author zzp
/// @since 2023/10/26
/// version v1.8.8
class ReplyItemView extends StatelessWidget {
  const ReplyItemView({super.key, required this.replyBean});

  /// 回复
  final ReplyBean replyBean;

  @override
  Widget build(BuildContext context) {
    var forumDetailViewModel = context.read<ForumDetailViewModel>();
    var commentItemViewModel = context.read<CommentItemViewModel>();
    return Padding(
      padding: const EdgeInsets.only(left: 50, bottom: 3),
      child: Ink(
        child: InkWell(
          onLongPress: () {
            CommentAndReplyControlDialog(
              isMine: replyBean.userInfo.userId == StuInfo.id,
              content: replyBean.content,
              replyClickCallback: () {
                forumDetailViewModel.showWriteCommentBottomSheet(
                  contentController:
                      commentItemViewModel.model.contentController,
                  publishClickCallback: (content) {
                    commentItemViewModel.postReply(
                        content: content, replyId: replyBean.userInfo.userId);
                  },
                );
              },
              deleteClickCallback: () {
                commentItemViewModel.deleteReply(replyBean);
              },
            ).showDialog(clickMaskDismiss: true);
          },
          onTap: () {
            forumDetailViewModel.showWriteCommentBottomSheet(
              contentController: commentItemViewModel.model.contentController,
              publishClickCallback: (content) {
                commentItemViewModel.postReply(
                    content: content, replyId: replyBean.userInfo.userId);
              },
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: CachedImage(
                  url: replyBean.userInfo.avatar,
                  size: 30,
                  fit: BoxFit.cover,
                  type: CachedImageType.webp,
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: replyBean.replyName == null
                        ? '${replyBean.userInfo.username}：'
                        : replyBean.userInfo.username,
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).primaryColor),
                    children: [
                      if (replyBean.replyName != null)
                        const TextSpan(
                          text: ' ${StringAssets.reply} ',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      if (replyBean.replyName != null)
                        TextSpan(
                          text: '${replyBean.replyName!}：',
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).primaryColor),
                        ),
                      TextSpan(
                        text: replyBean.content,
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        color: Colors.white,
      ),
    );
  }
}
