import 'package:cached_network_image/cached_network_image.dart';
import 'package:csust_edu_system/common/cachedimage/data/cached_image_type.dart';
import 'package:csust_edu_system/common/cachedimage/view/cached_normal_image.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:flutter/material.dart';

/// 缓存图片
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class CachedImage extends StatelessWidget {
  const CachedImage(
      {super.key,
      required this.url,
      this.type = CachedImageType.normal,
      this.size,
      this.errorWidget,
      this.progressWidget,
      this.fit});

  /// 图片url链接
  final String url;

  /// 缓存图片类型
  final CachedImageType type;

  /// 大小
  final double? size;

  /// 图片适配方式
  final BoxFit? fit;

  /// 错误情况下的widget
  final Widget? errorWidget;

  /// 加载中的widget
  final ProgressIndicatorBuilder? progressWidget;

  @override
  Widget build(BuildContext context) {
    String imageUrl;
    switch (type) {
      case CachedImageType.normal:
        imageUrl = url;
        break;
      case CachedImageType.thumb:
        imageUrl = url.suffixThumb();
        break;
      case CachedImageType.webp:
        imageUrl = url.suffixWebp();
        break;
    }
    return CachedNetworkImage(
      width: size,
      height: size,
      fit: fit,
      imageUrl: imageUrl,
      progressIndicatorBuilder: progressWidget ??
          (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => type == CachedImageType.thumb
          ? CachedImage(
              url: this.url,
              size: size,
              type: CachedImageType.webp,
              fit: fit,
            )
          : CachedNormalImage(
              url: this.url,
              size: size,
              fit: fit,
              errorWidget: errorWidget,
              progressWidget: progressWidget,
            ),
    );
  }
}
