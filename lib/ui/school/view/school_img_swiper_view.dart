import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:csust_edu_system/arch/baseview/seletor_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/school/jsonbean/banner_bean.dart';
import 'package:csust_edu_system/ui/school/viewmodel/school_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../route/fade_route.dart';
import '../data/school_data.dart';

/// 校园图片轮播图View
///
/// @author zzp
/// @since 2023/10/1
/// @version v1.8.8
class SchoolImgSwiperView extends StatelessWidget {
  const SchoolImgSwiperView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(12),
        height: 200,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SelectorView<SchoolViewModel, List<BannerBean>>(
              selector: (ctx, viewModel) => viewModel.model.bannerList,
              builder: (ctx, bannerList, _) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Swiper(
                    curve: Curves.fastOutSlowIn,
                    duration: 1200,
                    autoplay: true,
                    autoplayDelay: 5000,
                    itemBuilder: (BuildContext context, int index) {
                      return bannerList.isEmpty
                          ? Hero(
                              tag: schoolImgList[index],
                              child: Image.asset(
                                schoolImgList[index],
                                fit: BoxFit.fill,
                              ))
                          : Hero(
                              tag: bannerList[index],
                              child: Image.network(
                                bannerList[index].url,
                                fit: BoxFit.fill,
                              ));
                    },
                    itemCount: bannerList.isEmpty
                        ? schoolImgList.length
                        : bannerList.length,
                    onTap: (i) {
                      Navigator.of(context).push(
                        FadeRoute(
                          page: PhotoViewGallery.builder(
                            pageController: PageController(initialPage: i),
                            itemCount: bannerList.isEmpty
                                ? schoolImgList.length
                                : bannerList.length,
                            builder: (BuildContext context, int index) {
                              return bannerList.isEmpty
                                  ? PhotoViewGalleryPageOptions(
                                      onTapUp:
                                          (context, details, controllerValue) {
                                        Navigator.pop(context);
                                      },
                                      heroAttributes: PhotoViewHeroAttributes(
                                          tag: schoolImgList[index]),
                                      imageProvider:
                                          AssetImage(schoolImgList[index]),
                                      // initialScale: PhotoViewComputedScale.contained *
                                      //     0.95,
                                    )
                                  : PhotoViewGalleryPageOptions(
                                      onTapUp:
                                          (context, details, controllerValue) {
                                        Navigator.pop(context);
                                      },
                                      heroAttributes: PhotoViewHeroAttributes(
                                          tag: bannerList[index]),
                                      imageProvider: CachedNetworkImageProvider(
                                          bannerList[index].detailUrl),
                                      // initialScale: PhotoViewComputedScale.contained *
                                      //     0.95,
                                    );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: DefaultTextStyle(
                style: const TextStyle(
                    fontSize: 19.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                child: AnimatedTextKit(
                  repeatForever: true,
                  pause: const Duration(milliseconds: 1000),
                  animatedTexts: [
                    RotateAnimatedText(_welcomeString(),
                        alignment: Alignment.centerLeft,
                        duration: const Duration(milliseconds: 4000)),
                    RotateAnimatedText(
                        poemList[Random().nextInt(poemList.length)],
                        alignment: Alignment.centerLeft,
                        duration: const Duration(milliseconds: 4000)),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  String _welcomeString() {
    var result = StringAssets.emptyStr;
    DateTime dateTime = DateTime.now();
    var hour = dateTime.hour;
    if (hour >= 5 && hour < 11) {
      result = StringAssets.goodMorning;
    } else if (hour >= 11 && hour < 13) {
      result = StringAssets.goodNoon;
    } else if (hour >= 12 && hour < 18) {
      result = StringAssets.goodAfternoon;
    } else {
      result = StringAssets.goodEvening;
    }
    return result;
  }
}
