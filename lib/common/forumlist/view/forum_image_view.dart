import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:flutter/material.dart';

import '../../cachedimage/data/cached_image_type.dart';
import '../../cachedimage/view/cached_image.dart';
import 'forum_item_image_detail_view.dart';

/// 帖子图片View
///
/// @author zzp
/// @since 2023/10/25
/// @version v1.8.8
class ForumImageView extends StatelessWidget {
  const ForumImageView({super.key, required this.url, required this.images});

  /// 图片url
  final String url;

  /// 图片所在帖子的图片列表
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: url,
      child: GestureDetector(
        onTap: () {
          context.pushWithFadeRoute(
            ForumItemImageDetailView(
              images: images,
              initUrl: url,
            ),
          );
        },
        child: CachedImage(
          size: double.infinity,
          url: url,
          type: CachedImageType.webp,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
