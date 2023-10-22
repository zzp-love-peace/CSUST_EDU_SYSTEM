import 'dart:typed_data';

import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/network/http_helper.dart';
import 'package:csust_edu_system/util/typedef_util.dart';
import 'package:dio/dio.dart';

/// 缓存图片Service
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class CachedImageService extends BaseService {
  /// 下载图片
  ///
  /// [imgUrl] 图片链接
  /// [onDataSuccess] 获取数据成功回调
  void uploadImage(String imgUrl,
      {required OnDataSuccess<Uint8List> onDataSuccess}) {
    HttpHelper().get(imgUrl, responseType: ResponseType.bytes).then(
      (response) {
        Uint8List bytes = Uint8List.fromList(response.data);
        onDataSuccess.call(bytes, StringAssets.emptyStr);
      },
    );
  }
}
