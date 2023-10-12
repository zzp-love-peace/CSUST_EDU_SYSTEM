import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../route/fade_route.dart';

/// 电话卡轮播图
///
/// @author wk
/// @since 2023/9/25
/// @version v1.8.8
class TelephoneBannerView extends StatelessWidget {
  const TelephoneBannerView({super.key, required this.imgList});

  ///图片路径列表
  final List<String> imgList;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(12),
        height: 180,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Swiper(
                curve: Curves.fastOutSlowIn,
                duration: 1200,
                autoplay: true,
                autoplayDelay: 5000,
                itemBuilder: (BuildContext context, int index) {
                  return Hero(
                      tag: imgList[index],
                      child: Image.asset(
                        imgList[index],
                        fit: BoxFit.fill,
                      ));
                },
                itemCount: imgList.length,
                onTap: (i) {
                  Navigator.of(context).push(FadeRoute(
                      page: PhotoViewGallery.builder(
                    pageController: PageController(initialPage: i),
                    itemCount: imgList.length,
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        onTapUp: (context, details, controllerValue) {
                          Navigator.pop(context);
                        },
                        heroAttributes:
                            PhotoViewHeroAttributes(tag: imgList[index]),
                        imageProvider: AssetImage(imgList[index]),
                      );
                    },
                  )));
                },
              ),
            ),
          ],
        ));
  }
}
