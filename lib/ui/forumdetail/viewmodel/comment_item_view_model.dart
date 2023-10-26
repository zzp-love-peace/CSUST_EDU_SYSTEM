import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/forumdetail/jsonbean/reply_bean.dart';
import 'package:csust_edu_system/ui/forumdetail/model/comment_item_model.dart';
import 'package:csust_edu_system/ui/forumdetail/service/comment_item_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../ass/string_assets.dart';
import '../../../common/dialog/hint_dialog.dart';
import '../../../network/data/http_response_code.dart';

/// 评论ViewModel
///
/// @author zzp
/// @since 2023/10/25
/// version v1.8.8
class CommentItemViewModel
    extends BaseViewModel<CommentItemModel, CommentItemService> {
  CommentItemViewModel({required super.model});

  /// 反转展开状态
  void reverseExpandedState() {
    model.isExpanded = !model.isExpanded;
    notifyListeners();
  }

  /// 发布回复
  ///
  /// [content] 内容
  /// [replyId] 回复id（0为回复评论的回复，其他为回复对应id回复的回复）
  void postReply({required String content, required int replyId}) {
    service?.postReply(
      commentId: model.commentBean.id,
      replyId: replyId,
      content: content,
      onPrepare: () {
        SmartDialog.showLoading(msg: StringAssets.uploading);
      },
      onComplete: () {
        SmartDialog.dismiss();
      },
      onDataSuccess: (data, msg) {
        context.pop();
        model.contentController.clear();
        model.commentBean.replyList.insert(0, ReplyBean.fromJson(data));
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

  /// 删除回复
  ///
  /// [replyBean] 回复
  void deleteReply(ReplyBean replyBean) {
    service?.deleteReply(
      replyId: replyBean.id,
      onDataSuccess: (data, msg) {
        model.commentBean.replyList.remove(replyBean);
        notifyListeners();
      },
    );
  }

  @override
  CommentItemService? createService() => CommentItemService();
}
