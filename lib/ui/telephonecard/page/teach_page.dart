import 'package:csust_edu_system/ass/image_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../route/fade_route.dart';

/// 教程查看页
///
/// @author wk
/// @since 2023/9/27
/// @version v1.8.8
class TeachPage extends StatelessWidget {
  const TeachPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.create(StringAssets.tutorialView),
      body: ListView(
        children: [
          _paddingText(StringAssets.tutorial1, 10, 0),
          _paddingText(StringAssets.tutorial2, 10, 0),
          _image(context, ImageAssets.equity1),
          _paddingText(StringAssets.networkLinkTutorial, 20, 0),
          _image(context, ImageAssets.equity2),
          _paddingText(StringAssets.faultFix, 20, 50),
        ],
      ),
    );
  }

  /// 获取带Padding的Text
  ///
  /// [value]text的值
  /// [top]padding的top高度
  /// [bottom]padding的bottom值
  Widget _paddingText(String value, double top, double bottom) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, top, 20, bottom),
        child: Text(value,
            style: const TextStyle(color: Colors.black, fontSize: 16)));
  }

  /// 获取可点击查看的图片Img
  ///
  /// [context] BuildContext
  /// [imgPath] 图片路径
  Widget _image(BuildContext context, String imgPath) {
    return Center(
        child: GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Image(image: AssetImage(imgPath)),
      ),
      onTap: () {
        Navigator.of(context).push(FadeRoute(
            page: PhotoViewGallery.builder(
          itemCount: 1,
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              onTapUp: (context, details, controllerValue) {
                Navigator.pop(context);
              },
              imageProvider: AssetImage(imgPath),
            );
          },
        )));
      },
    ));
  }
}
