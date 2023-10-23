import 'package:cached_network_image/cached_network_image.dart';
import 'package:csust_edu_system/arch/basedata/empty_model.dart';
import 'package:csust_edu_system/common/cachedimage/data/cached_image_type.dart';
import 'package:csust_edu_system/common/cachedimage/view/cached_normal_image.dart';
import 'package:csust_edu_system/common/cachedimage/viewmodel/cached_image_view_model.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../../../ass/string_assets.dart';

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
      this.fit,
      this.isShowDetail = false});

  /// 图片url链接
  final String url;

  /// 缓存图片类型
  final CachedImageType type;

  /// 大小
  final double? size;

  /// 图片适配方式
  final BoxFit? fit;

  /// 是否点击进入图片详情
  final bool isShowDetail;

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
    return GestureDetector(
      onTap: isShowDetail
          ? () {
              context.pushWithFadeRoute(
                PhotoViewGallery.builder(
                  itemCount: 1,
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions.customChild(
                        onTapUp: (context, details, controllerValue) {
                          context.pop();
                        },
                        child: _imageDetailView());
                  },
                ),
              );
            }
          : null,
      child: CachedNetworkImage(
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
      ),
    );
  }

  Widget _imageDetailView() {
    return ChangeNotifierProvider(
      create: (_) => CachedImageViewModel<EmptyModel>(model: EmptyModel()),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: CachedImage(
              url: url,
              type: CachedImageType.webp,
              errorWidget: const Center(
                child: Icon(
                  Icons.question_mark,
                  color: Colors.white,
                ),
              ),
              progressWidget: (ctx, url, downloadProgress) => Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: Row(
              children: [
                const Text(
                  StringAssets.image,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                const Spacer(),
                Builder(
                  builder: (innerContext) {
                    var viewModel =
                        innerContext.read<CachedImageViewModel<EmptyModel>>();
                    return IconButton(
                      icon: const Icon(
                        Icons.download,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        viewModel.uploadImage(url);
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
