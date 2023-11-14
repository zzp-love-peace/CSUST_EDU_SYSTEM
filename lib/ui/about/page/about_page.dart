import 'package:csust_edu_system/ass/image_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:flutter/material.dart';

import '../../../arch/baseview/consumer_view.dart';
import '../../../common/versionchecker/viewmodel/version_checker_view_model.dart';
import '../../../data/app_info.dart';

/// 关于页面
///
/// @author zzp
/// @since 2023/10/27
/// @version v1.8.8
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.create(StringAssets.about),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                ImageAssets.logo,
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('${StringAssets.versionNum}: ${AppInfo.version}'),
            const SizedBox(
              height: 15,
            ),
            const Text(StringAssets.appName),
            const SizedBox(
              height: 15,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  side: const BorderSide(width: 1),
                ),
                onPressed: () {
                  context
                      .readViewModel<VersionCheckerViewModel>()
                      .checkoutVersion();
                },
                child: ConsumerView<VersionCheckerViewModel>(
                  builder: (context, appInfo, _) => Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          StringAssets.checkoutUpdate,
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ),
                      if (appInfo.model.hasNewVersion)
                        const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.circle,
                            color: Colors.red,
                            size: 9,
                          ),
                        ),
                    ],
                  ),
                )),
            const Card(
              margin: EdgeInsets.fromLTRB(24, 15, 24, 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    StringAssets.aboutUs,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24, 12, 24, 20),
                    child: Text('本app由长沙理工大学计通学院凡路实验室移动开发部20级部长兼IOS俱乐部成员开发，'
                        '对app有任何的建议，都可以反馈给我们。非常期待您推荐给身边的同学。'),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              'made by zzp',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
