import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/common/forumlist/service/forum_item_service.dart';
import 'package:csust_edu_system/util/typedef_util.dart';

/// 帖子详情Service
///
/// @author zzp
/// @since 2023/10/23
/// @version v1.8.8
class ForumDetailService extends ForumItemService {
  /// 获取帖子详情
  ///
  /// [forumId] 帖子id
  /// [onDataSuccess] 获取数据成功回调
  void getForumDetail(
      {required int forumId, required OnDataSuccess<KeyMap> onDataSuccess}) {
    get(UrlAssets.getForumDetail,
        params: {KeyAssets.id: forumId}, onDataSuccess: onDataSuccess);
  }

  /// 删除帖子
  ///
  /// [forumId] 帖子id
  /// [onDataSuccess] 获取数据成功回调
  void deleteForum(
      {required int forumId, required OnDataSuccess onDataSuccess}) {
    post(UrlAssets.deleteForumOrCommentOrReply,
        params: {KeyAssets.postId: forumId}, onDataSuccess: onDataSuccess);
  }

  /// 删除评论
  ///
  /// [commentId] 评论id
  /// [onDataSuccess] 获取数据成功回调
  void deleteComment(
      {required int commentId, required OnDataSuccess onDataSuccess}) {
    post(UrlAssets.deleteForumOrCommentOrReply,
        params: {KeyAssets.commentId: commentId}, onDataSuccess: onDataSuccess);
  }

  /// 发布评论
  ///
  /// [forumId] 帖子id
  /// [content] 内容
  /// [onPrepare] 请求前回调
  /// [onComplete] 请求完成回调
  /// [onDataSuccess] 获取数据成功回调
  /// [onDataFail] 获取数据失败回调
  void postComment(
      {required int forumId,
      required String content,
      OnPrepare? onPrepare,
      required OnDataSuccess<KeyMap> onDataSuccess,
      OnDataFail? onDataFail,
      OnComplete? onComplete}) {
    post(UrlAssets.postComment,
        params: {KeyAssets.postId: forumId, KeyAssets.content: content},
        onPrepare: onPrepare,
        onComplete: onComplete,
        onDataSuccess: onDataSuccess,
        onDataFail: onDataFail);
  }

  /// 举报帖子
  ///
  /// [forumId] 帖子id
  /// [onPrepare] 请求前回调
  /// [onComplete] 请求完成回调
  /// [onDataSuccess] 获取数据成功回调
  ///
  void reportForum(
      {required int forumId,
      required OnDataSuccess onDataSuccess,
      OnComplete? onComplete,
      OnPrepare? onPrepare}) {
    post(UrlAssets.reportForum,
        params: {KeyAssets.postId: forumId},
        onDataSuccess: onDataSuccess,
        onComplete: onComplete,
        onPrepare: onPrepare);
  }
}
