import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// 普通缓存图片
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class CachedNormalImage extends StatelessWidget {
  const CachedNormalImage(
      {super.key,
      required this.url,
      this.size,
      this.errorWidget,
      this.progressWidget,
      this.fit});

  /// 图片url链接
  final String url;

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
    return CachedNetworkImage(
      width: size,
      height: size,
      fit: fit,
      imageUrl: url,
      progressIndicatorBuilder: progressWidget ??
          (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
    );
  }
}
