import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/util/typedef_util.dart';
import 'package:dio/dio.dart';

/// 帖子Item Service
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class ForumItemService extends BaseService {
  /// 广告帖子点击打点
  ///
  /// [forumId] 帖子id
  void clickAdvertise(int forumId) {
    post(
      UrlAssets.clickAdvertise,
      params: FormData.fromMap(
        {KeyAssets.id: forumId},
      ),
      onDataSuccess: (data, msg) {},
    );
  }

  /// 广告帖子点赞打点
  ///
  /// [forumId] 帖子id
  void likeAdvertise(int forumId) {
    post(
      UrlAssets.likeAdvertise,
      params: FormData.fromMap(
        {KeyAssets.id: forumId},
      ),
      onDataSuccess: (data, msg) {},
    );
  }

  /// 点赞帖子
  ///
  /// [forumId] 帖子id
  /// [onDataSuccess] 获取数据成功回调
  void likeForum(int forumId, {required OnDataSuccess onDataSuccess}) {
    get(UrlAssets.likeForum,
        params: {KeyAssets.id: forumId}, onDataSuccess: onDataSuccess);
  }

  /// 收藏帖子
  ///
  /// [forumId] 帖子id
  /// [onDataSuccess] 获取数据成功回调
  void collectForum(int forumId, {required OnDataSuccess onDataSuccess}) {
    get(UrlAssets.collectForum,
        params: {KeyAssets.id: forumId}, onDataSuccess: onDataSuccess);
  }
}
