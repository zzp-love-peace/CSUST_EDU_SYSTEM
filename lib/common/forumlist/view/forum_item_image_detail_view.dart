import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/cachedimage/data/cached_image_type.dart';
import 'package:csust_edu_system/common/forumlist/model/forum_item_image_detail_model.dart';
import 'package:csust_edu_system/common/forumlist/viewmodel/forum_item_image_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../../cachedimage/view/cached_image.dart';

/// 帖子图片详情View
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class ForumItemImageDetailView extends StatelessWidget {
  const ForumItemImageDetailView(
      {super.key, required this.images, required this.initUrl});

  /// 图片list
  final List<String> images;

  /// 首张图片url
  final String initUrl;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForumItemImageDetailViewModel(
        model: ForumItemImageDetailModel(curImgIndex: images.indexOf(initUrl)),
      ),
      child: ConsumerView<ForumItemImageDetailViewModel>(
        builder: (ctx, viewModel, _) {
          return PhotoViewGallery.builder(
            onPageChanged: (index) {
              viewModel.setCurImgIndex(index);
            },
            pageController:
                PageController(initialPage: images.indexOf(initUrl)),
            itemCount: images.length,
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions.customChild(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CachedImage(
                        url: images[index],
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
                          Text(
                            '${viewModel.model.curImgIndex + 1}/${images.length}',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.download,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              String url = images[viewModel.model.curImgIndex];
                              viewModel.uploadImage(url);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                onTapUp: (context, details, controllerValue) {
                  Navigator.pop(context);
                },
                heroAttributes: PhotoViewHeroAttributes(tag: images[index]),
              );
            },
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
