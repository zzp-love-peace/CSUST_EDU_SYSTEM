import 'package:csust_edu_system/ass/image_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

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
          _paddingText(text: StringAssets.tutorial1, top: 10, bottom: 0),
          _paddingText(text: StringAssets.tutorial2, top: 10, bottom: 0),
          _image(context, imgPath: ImageAssets.equity1),
          _paddingText(
              text: StringAssets.networkLinkTutorial, top: 20, bottom: 0),
          _image(context, imgPath: ImageAssets.equity2),
          _paddingText(text: StringAssets.faultFix, top: 20, bottom: 50),
        ],
      ),
    );
  }

  /// 获取带Padding的Text
  ///
  /// [value] text的值
  /// [top] padding的top高度
  /// [bottom] padding的bottom值
  Widget _paddingText(
      {required String text, required double top, required double bottom}) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, top, 20, bottom),
        child: Text(text,
            style: const TextStyle(color: Colors.black, fontSize: 16)));
  }

  /// 获取可点击查看的图片Img
  ///
  /// [context] BuildContext
  /// [imgPath] 图片路径
  Widget _image(BuildContext context, {required String imgPath}) {
    return Center(
        child: GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Image(image: AssetImage(imgPath)),
      ),
      onTap: () {
        context.pushWithFadeRoute(
          PhotoViewGallery.builder(
            itemCount: 1,
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                onTapUp: (context, details, controllerValue) {
                  Navigator.pop(context);
                },
                imageProvider: AssetImage(imgPath),
              );
            },
          ),
        );
      },
    ));
  }
}
