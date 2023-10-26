import 'package:csust_edu_system/arch/basedata/page_result_bean.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/forumlist/jsonbean/forum_bean.dart';
import 'package:csust_edu_system/common/forumlist/viewmodel/forum_like_and_collect_view_model.dart';
import 'package:csust_edu_system/data/page_result_code.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ext/list_extension.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/network/data/http_response_code.dart';
import 'package:csust_edu_system/ui/forumdetail/jsonbean/comment_bean.dart';
import 'package:csust_edu_system/ui/forumdetail/model/forum_detail_model.dart';
import 'package:csust_edu_system/ui/forumdetail/service/forum_detail_service.dart';
import 'package:csust_edu_system/ui/forumdetail/view/write_comment_bottom_sheet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../common/dialog/hint_dialog.dart';

/// 帖子详情ViewModel
///
/// @author zzp
/// @since 2023/10/23
/// @version v1.8.8
class ForumDetailViewModel
    extends ForumLikeAndCollectViewModel<ForumDetailModel, ForumDetailService> {
  ForumDetailViewModel({required super.model});

  /// 获取帖子详情
  void getForumDetail() {
    if (model.forumBean.isAdvertise) return;
    service?.getForumDetail(
      forumId: model.forumBean.id,
      onDataSuccess: (data, msg) {
        model.commentList = (data[KeyAssets.commentInfo] as List)
            .map((json) => CommentBean.fromJson(json))
            .toList();
        model.forumBean.likeNum = data[KeyAssets.indexPost][KeyAssets.likeNum];
        model.forumBean.commentNum =
            data[KeyAssets.indexPost][KeyAssets.commentNum];
        notifyListeners();
      },
    );
  }

  /// 删除帖子
  void deleteForum() {
    service?.deleteForum(
      forumId: model.forumBean.id,
      onDataSuccess: (data, msg) {
        StringAssets.deleteSuccess.showToast();
        context.pop<ForumBean>(
            result:
                PageResultBean(PageResultCode.forumDelete, model.forumBean));
      },
    );
  }

  /// 举报帖子
  void reportForum() {
    service?.reportForum(
      forumId: model.forumBean.id,
      onPrepare: () {
        SmartDialog.showLoading(msg: StringAssets.reporting);
      },
      onComplete: () {
        SmartDialog.dismiss();
      },
      onDataSuccess: (data, msg) {
        const HintDialog(
                title: StringAssets.tips,
                subTitle: StringAssets.reportSuccessTips)
            .showDialog();
      },
    );
  }

  /// 删除评论
  ///
  /// [commentBean] 评论
  void deleteComment(CommentBean commentBean) {
    service?.deleteComment(
      commentId: commentBean.id,
      onDataSuccess: (data, msg) {
        model.forumBean.commentNum--;
        model.commentList = model.commentList.removeCanNotify(commentBean);
        notifyListeners();
      },
    );
  }

  /// 发布评论
  ///
  /// [content] 内容
  void postComment(String content) {
    service?.postComment(
      forumId: model.forumBean.id,
      content: content,
      onPrepare: () {
        SmartDialog.showLoading(msg: StringAssets.uploading);
      },
      onComplete: () {
        SmartDialog.dismiss();
      },
      onDataSuccess: (data, msg) {
        context.pop();
        model.commentController.clear();
        model.commentList =
            model.commentList.insertCanNotify(CommentBean.fromJson(data), 0);
        model.forumBean.commentNum++;
        notifyListeners();
      },
      onDataFail: (code, msg) {
        if (code == HttpResponseCode.bannedOfSpeaking) {
          HintDialog(title: StringAssets.tips, subTitle: msg).showDialog();
        } else {
          msg.showToast();
        }
      },
    );
  }

  /// 展示写评论底部Sheet
  ///
  /// [contentController] 内容输入控制器
  /// [hint] 提示语句
  /// [publishClickCallback] 发布按钮点击回调
  void showWriteCommentBottomSheet(
      {required TextEditingController contentController,
      String hint = StringAssets.saySomething,
      required void Function(String content) publishClickCallback}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
      ),
      builder: (ctx) => WriteCommentBottomSheet(
        contentController: contentController,
        hint: hint,
        publishClickCallback: publishClickCallback,
      ),
    );
  }

  @override
  ForumDetailService? createService() => ForumDetailService();
}
