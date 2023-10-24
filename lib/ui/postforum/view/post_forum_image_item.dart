import 'dart:io';

import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:csust_edu_system/arch/baseview/seletor_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/postforum/view/add_image_button_view.dart';
import 'package:csust_edu_system/ui/postforum/viewmodel/post_forum_view_model.dart';
import 'package:csust_edu_system/util/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

/// 发帖图片item
///
/// @author zzp
/// @since 2023/10/23
/// @version v1.8.8
class PostForumImageItem extends StatelessWidget {
  const PostForumImageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ((MediaQuery.of(context).size.width - 48) / 3) + 24,
      margin: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: SelectorView<PostForumViewModel, List<String>>(
        selector: (ctx, viewModel) => viewModel.model.imgPaths,
        builder: (ctx, imgPaths, _) => Stack(
          alignment: Alignment.centerLeft,
          children: [
            AnimatedOpacity(
              opacity: imgPaths.length == 1 ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 2.1),
                child: const Text(
                  StringAssets.postForumImgTips,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ImplicitlyAnimatedList<String>(
                updateDuration: const Duration(milliseconds: 300),
                insertDuration: const Duration(milliseconds: 300),
                removeDuration: const Duration(milliseconds: 300),
                items: imgPaths,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                areItemsTheSame: (a, b) => a == b,
                itemBuilder: (context, animation, item, index) {
                  return WidgetUtil.buildFadeWidgetHorizontal(
                      _forumImgView(context, path: item, imgPaths: imgPaths),
                      animation);
                },
                removeItemBuilder: (context, animation, oldItem) {
                  return WidgetUtil.buildFadeWidgetHorizontal(
                      _forumImgView(context, path: oldItem, imgPaths: imgPaths),
                      animation);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 帖子图片
  ///
  /// [context] context
  /// [path] 图片路径
  /// [imgPaths] 图片路径列表
  Widget _forumImgView(BuildContext context,
      {required String path, required List<String> imgPaths}) {
    var postForumViewModel = context.read<PostForumViewModel>();
    if (path.isEmpty) {
      return AddImageButtonView(
        addImageCallback: (path) {
          postForumViewModel.insertImgPathAtFirst(path);
        },
      );
    }
    return Hero(
      tag: path + imgPaths.indexOf(path).toString(),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PhotoViewGallery.builder(
                pageController:
                    PageController(initialPage: imgPaths.indexOf(path)),
                itemCount: imgPaths.length,
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    onTapUp: (context, details, controllerValue) {
                      Navigator.pop(context);
                    },
                    heroAttributes: PhotoViewHeroAttributes(
                        tag: imgPaths[index] + index.toString()),
                    imageProvider: FileImage(File(imgPaths[index])),
                  );
                },
              ),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Image.file(
              File(path),
              fit: BoxFit.cover,
              width: (MediaQuery.of(context).size.width - 48) / 3,
            ),
            GestureDetector(
              onTap: () {
                postForumViewModel.removeImgPath(path);
              },
              child: Container(
                width: 24,
                height: 24,
                color: Colors.black54,
                child: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
