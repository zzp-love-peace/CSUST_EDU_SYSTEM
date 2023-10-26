import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/cachedimage/data/cached_image_type.dart';
import 'package:csust_edu_system/common/cachedimage/view/cached_image.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/ui/forumdetail/jsonbean/comment_bean.dart';
import 'package:csust_edu_system/ui/forumdetail/model/comment_item_model.dart';
import 'package:csust_edu_system/ui/forumdetail/view/comment_and_reply_control_dialog.dart';
import 'package:csust_edu_system/ui/forumdetail/view/reply_list_view.dart';
import 'package:csust_edu_system/ui/forumdetail/viewmodel/comment_item_view_model.dart';
import 'package:csust_edu_system/ui/forumdetail/viewmodel/forum_detail_view_model.dart';
import 'package:csust_edu_system/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 评论item
///
/// @author zzp
/// @since 2023/10/25
/// version v1.8.8
class CommentItemView extends StatelessWidget {
  const CommentItemView({super.key, required this.commentBean});

  /// 评论
  final CommentBean commentBean;

  @override
  Widget build(BuildContext context) {
    var forumDetailViewModel = context.read<ForumDetailViewModel>();
    var commentItemViewModel =
        CommentItemViewModel(model: CommentItemModel(commentBean: commentBean));
    return ChangeNotifierProxyProvider<ForumDetailViewModel,
        CommentItemViewModel>(
      create: (_) => commentItemViewModel,
      update: (ctx, forumDetailViewModel, _) => commentItemViewModel,
      child: Card(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Ink(
          child: InkWell(
            onLongPress: () {
              CommentAndReplyControlDialog(
                isMine: commentBean.userInfo.userId == StuInfo.id,
                content: commentBean.content,
                replyClickCallback: () {
                  _showWriteCommentBottomSheet(
                      forumDetailViewModel, commentItemViewModel);
                },
                deleteClickCallback: () {
                  forumDetailViewModel.deleteComment(commentBean);
                },
              ).showDialog(clickMaskDismiss: true);
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: CachedImage(
                          url: commentBean.userInfo.avatar,
                          size: 40,
                          fit: BoxFit.cover,
                          type: CachedImageType.webp,
                          isShowDetail: true,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        commentBean.userInfo.username,
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 8, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            commentBean.content,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        DateUtil.getForumDateString(commentBean.createTime),
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      TextButton(
                        onPressed: () {
                          _showWriteCommentBottomSheet(
                              forumDetailViewModel, commentItemViewModel);
                        },
                        child: Text(
                          StringAssets.reply,
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const ReplyListView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 展示写评论底部Sheet
  ///
  /// [forumDetailViewModel] 帖子详情ViewModel
  /// [commentItemViewModel] 评论ViewModel
  void _showWriteCommentBottomSheet(ForumDetailViewModel forumDetailViewModel,
      CommentItemViewModel commentItemViewModel) {
    forumDetailViewModel.showWriteCommentBottomSheet(
      contentController: commentItemViewModel.model.contentController,
      hint: '${StringAssets.replyTo} ${commentBean.userInfo.username}',
      publishClickCallback: (content) {
        commentItemViewModel.postReply(content: content, replyId: 0);
      },
    );
  }
}
