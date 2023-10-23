import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/common/cachedimage/service/cached_image_service.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../../../ass/key_assets.dart';
import '../../../ass/string_assets.dart';

/// 缓存图片ViewModel
///
/// @author zzp
/// @since 2023/10/22
/// @version v1.8.8
class CachedImageViewModel<M> extends BaseViewModel<M, CachedImageService> {
  CachedImageViewModel({required super.model});

  @override
  CachedImageService? createService() => CachedImageService();

  /// 下载图片
  ///
  /// [imgUrl] 图片链接
  void uploadImage(String imgUrl) {
    service?.uploadImage(
      imgUrl,
      onDataSuccess: (data, msg) async {
        var result = await ImageGallerySaver.saveImage(data, quality: 100);
        if (result[KeyAssets.isSuccess] == true) {
          StringAssets.downloadSuccess.showToast();
        } else {
          (result[KeyAssets.errorMessage] as String).showToast();
        }
      },
    );
  }
}
