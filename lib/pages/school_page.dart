import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:csust_edu_system/data/poem_data.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/homes/association_home.dart';
import 'package:csust_edu_system/homes/electricity_home.dart';
import 'package:csust_edu_system/homes/exam_home.dart';
import 'package:csust_edu_system/homes/grade_home.dart';
import 'package:csust_edu_system/homes/recruit_home.dart';
import 'package:csust_edu_system/network/http_manager.dart';
import 'package:csust_edu_system/route/fade_route.dart';
import 'package:csust_edu_system/ui/schoolnotice/page/shcool_notice_page.dart';
import 'package:csust_edu_system/ui/telephonecard/page/telephone_page.dart';
import 'package:csust_edu_system/widgets/none_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../widgets/custom_toast.dart';

class SchoolPage extends StatefulWidget {
  const SchoolPage({Key? key}) : super(key: key);

  @override
  State<SchoolPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  List<Widget> _noticeList = [];
  final List<String> _imgList = [
   'assets/images/school7.jpg',
    'assets/images/school1.jpg',
    'assets/images/school2.jpg',
    'assets/images/school3.jpg',
    'assets/images/school4.jpg',
    'assets/images/school6.jpg',
  ];

  List _bannerList = [];

  @override
  void initState() {
    super.initState();
    _initNoticeList();
    _getBannerImg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.white,
          // systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
          title: const Text(
            "校园",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            if (_noticeList.isEmpty)
              IconButton(
                  onPressed: () {
                    _initNoticeList();
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ))
          ],
        ),
        body: ListView(
          children: [
            _schoolSwiper(),
            _functionCar(),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 0, 0, 15),
              child: Text(
                '教务公告',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),
            _noticeList.isNotEmpty
                ? Column(
                    children: _noticeList,
                  )
                : Column(
                    children: const [
                      NoneLottie(hint: '教务异常...'),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  )
          ],
        ));
  }

  Widget _schoolSwiper() {
    return Container(
        margin: const EdgeInsets.all(12),
        height: 200,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Swiper(
                curve: Curves.fastOutSlowIn,
                duration: 1200,
                autoplay: true,
                autoplayDelay: 5000,
                itemBuilder: (BuildContext context, int index) {
                  return _bannerList.isEmpty
                      ? Hero(
                          tag: _imgList[index],
                          child: Image.asset(
                            _imgList[index],
                            fit: BoxFit.fill,
                          ))
                      : Hero(
                          tag: _bannerList[index],
                          child: Image.network(
                            _bannerList[index]['url'],
                            fit: BoxFit.fill,
                          ));
                },
                itemCount:
                    _bannerList.isEmpty ? _imgList.length : _bannerList.length,
                onTap: (i) {
                  Navigator.of(context).push(FadeRoute(
                      page: PhotoViewGallery.builder(
                    pageController: PageController(initialPage: i),
                    itemCount: _bannerList.isEmpty
                        ? _imgList.length
                        : _bannerList.length,
                    builder: (BuildContext context, int index) {
                      return _bannerList.isEmpty
                          ? PhotoViewGalleryPageOptions(
                              onTapUp: (context, details, controllerValue) {
                                Navigator.pop(context);
                              },
                              heroAttributes: PhotoViewHeroAttributes(tag: _imgList[index]),
                              imageProvider: AssetImage(_imgList[index]),
                              // initialScale: PhotoViewComputedScale.contained *
                              //     0.95,
                            )
                          : PhotoViewGalleryPageOptions(
                              onTapUp: (context, details, controllerValue) {
                                Navigator.pop(context);
                              },
                              heroAttributes: PhotoViewHeroAttributes(tag: _bannerList[index]),
                              imageProvider: CachedNetworkImageProvider(
                                  _bannerList[index]['detailUrl']),
                              // initialScale: PhotoViewComputedScale.contained *
                              //     0.95,
                            );
                    },
                  )));
                },
              ),
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

  Widget _functionCar() {
    return Card(
      // elevation: 0,
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: const [
              SizedBox(
                width: 20,
              ),
              Icon(Icons.functions),
              SizedBox(
                width: 12,
              ),
              Text(
                '主要功能',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              _functionItem('成绩查询', 'assets/images/img_grade.png', () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const GradeHome()));
              }),
              _functionItem('考试安排', 'assets/images/img_exam.png', () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ExamHome()));
              }),
              _functionItem('电费查询', 'assets/images/img_electricity.png', () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ElectricityHome()));
              }),
              // _functionItem('电话簿', 'assets/images/img_phone_book.png', () {}),
            ],
          ),
          Row(
            children: [
              _functionItem('校园地图', 'assets/images/img_map.png', () {
                var mapImages = [
                  'assets/images/school_map1.jpg',
                  'assets/images/school_map2.jpg'
                ];
                Navigator.of(context).push(FadeRoute(
                    page: PhotoViewGallery.builder(
                  itemCount: mapImages.length,
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      onTapUp: (context, details, controllerValue) {
                        Navigator.pop(context);
                      },
                      imageProvider: AssetImage(mapImages[index]),
                    );
                  },
                )));
              }),
              _functionItem('长理社团', 'assets/images/img_group.png', () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AssociationHome()));
              }),
              // _functionItem('综测竞赛', 'assets/images/img_final_test.png', () {}),
              _functionItem('兼职资讯', 'assets/images/img_work.png', () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TelephonePage()));
              }),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget _functionItem(String label, String path, Function tapCallback) {
    return Expanded(
        flex: 1,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Image.asset(
                path,
                width: 24,
                height: 24,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(label),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
          onTap: () {
            tapCallback();
          },
        ));
  }

  String _welcomeString() {
    var result = "";
    DateTime dateTime = DateTime.now();
    var hour = dateTime.hour;
    if (hour >= 5 && hour < 11) {
      result = "上午好";
    } else if (hour >= 11 && hour < 13) {
      result = "中午好";
    } else if (hour >= 12 && hour < 18) {
      result = "下午好";
    } else {
      result = "晚上好";
    }
    return result;
  }

  _initNoticeList() async {
    var response =
        await HttpManager().getNoticeList(StuInfo.cookie, StuInfo.token);
    if (response.isNotEmpty) {
      if (response['code'] == 200) {
        // print(response);
        List<Widget> result = [];
        for (var notice in response['data']) {
          if (notice['ggid'] != null) {
            result.add(
                _noticeItem(notice['ggid'], notice['title'], notice['time']));
          }
        }
        setState(() {
          _noticeList = result;
        });
      } else {
        setState(() {
          _noticeList = [];
        });
        SmartDialog.compatible
            .showToast('', widget: CustomToast(response['msg']));
      }
    }
  }

  _getBannerImg() {
    HttpManager().getBannerImg(StuInfo.token).then((value) {
      if (value.isNotEmpty) {
       // print(value);
        if (value['code'] == 200) {
          setState(() {
            _bannerList = value['data'];
          });
        } else {
          SmartDialog.compatible
              .showToast('', widget: CustomToast(value['msg']));
        }
      } else {
        SmartDialog.compatible
            .showToast('', widget: const CustomToast('出现异常了'));
      }
    }, onError: (_) {
      SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了'));
    });
  }

  Widget _noticeItem(String ggid, String title, String time) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(12, 3, 12, 8),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Ink(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SchoolNoticePage(ggid)));
            },
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 18, 10, 18),
                      child: ClipOval(
                          child: Image.asset("assets/images/csust_logo.png",
                              width: 60, height: 60, fit: BoxFit.cover)),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 12),
                      child: Text(
                        title,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 3),
                  child: Text(
                    time.substring(0, 10),
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
