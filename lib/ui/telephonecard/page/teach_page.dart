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
      appBar: CommonAppBar.create(StringAssets.teach),
      body: ListView(
        children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text(StringAssets.teach1,
                  style: TextStyle(color: Colors.black, fontSize: 16))),
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text(StringAssets.teach2,
                  style: TextStyle(color: Colors.black, fontSize: 16))),
          Center(
              child: GestureDetector(
            child: const Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Image(image: AssetImage(ImageAssets.equity1)),
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
                    imageProvider: const AssetImage(ImageAssets.equity1),
                  );
                },
              )));
            },
          )),
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(StringAssets.teach3,
                  style: TextStyle(color: Colors.black, fontSize: 16))),
          Center(
              child: GestureDetector(
            child: const Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Image(image: AssetImage(ImageAssets.equity2)),
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
                    imageProvider: const AssetImage(ImageAssets.equity2),
                  );
                },
              )));
            },
          )),
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
              child: Text(StringAssets.faultFix,
                  style: TextStyle(color: Colors.black, fontSize: 16))),
        ],
      ),
    );
  }
}
