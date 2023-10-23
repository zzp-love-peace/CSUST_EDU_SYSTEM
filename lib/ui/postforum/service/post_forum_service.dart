import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/util/typedef_util.dart';
import 'package:dio/dio.dart';

/// 发帖Service
///
/// @author zzp
/// @since 2023/10/23
/// @version v1.8.8
class PostForumService extends BaseService {
  /// 发帖
  ///
  /// [themeId] 标签id
  /// [content] 帖子内容
  /// [isAnonymous] 是否匿名
  /// [images] 图片
  /// [onDataSuccess] 获取数据成功回调
  /// [onFinish] 请求结束回调
  void postForum(
      {required int themeId,
      required String content,
      required bool isAnonymous,
      required List<MultipartFile> images,
      required OnDataSuccess<KeyMap> onDataSuccess,
      OnFinish? onFinish}) {
    var params = FormData.fromMap({
      KeyAssets.themeId: themeId,
      KeyAssets.content: content,
      KeyAssets.isAnonymous: isAnonymous,
      KeyAssets.images: images
    });
    post(UrlAssets.postForum,
        params: params, onDataSuccess: onDataSuccess, onFinish: onFinish);
  }
}
