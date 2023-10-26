import 'package:csust_edu_system/arch/baseservice/base_service.dart';

import '../../../ass/key_assets.dart';
import '../../../ass/url_assets.dart';
import '../../../util/typedef_util.dart';

/// 评论Service
///
/// @author zzp
/// @since 2023/10/25
/// @version v1.8.8
class CommentItemService extends BaseService {
  /// 发布回复
  ///
  /// [commentId] 评论id（该条回复所回复的评论id）
  /// [replyId] 回复id（该条回复所回复的回复id）
  /// [content] 内容
  /// [onPrepare] 请求前回调
  /// [onComplete] 请求完成回调
  /// [onDataSuccess] 获取数据成功回调
  /// [onDataFail] 获取数据失败回调
  void postReply(
      {required int commentId,
      required int replyId,
      required String content,
      OnPrepare? onPrepare,
      required OnDataSuccess<KeyMap> onDataSuccess,
      OnDataFail? onDataFail,
      OnComplete? onComplete}) {
    post(UrlAssets.postReply,
        params: {
          KeyAssets.commentId: commentId,
          KeyAssets.replyId: replyId,
          KeyAssets.content: content
        },
        onPrepare: onPrepare,
        onComplete: onComplete,
        onDataSuccess: onDataSuccess,
        onDataFail: onDataFail);
  }

  /// 删除回复
  ///
  /// [replyId] 回复id
  /// [onDataSuccess] 获取数据成功回调
  void deleteReply(
      {required int replyId, required OnDataSuccess onDataSuccess}) {
    post(UrlAssets.deleteForumOrCommentOrReply,
        params: {KeyAssets.replyId: replyId}, onDataSuccess: onDataSuccess);
  }
}
