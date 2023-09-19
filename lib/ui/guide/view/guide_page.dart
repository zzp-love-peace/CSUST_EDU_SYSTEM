import 'package:csust_edu_system/arch/basedata/empty_model.dart';
import 'package:csust_edu_system/ass/image_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/guide/viewmodel/guide_viewmodel.dart';
import 'package:csust_edu_system/utils/extension_uitl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/sp/sp_util.dart';

/// 开屏引导页
///
/// @author zzp
/// @since 2023/9/18
class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GuideViewModel(model: EmptyModel()),
      child: const GuideHome());
  }
}

/// 开屏引导页Home
///
/// @author zzp
/// @since 2023/9/18
class GuideHome extends StatefulWidget {
  const GuideHome({super.key});

  @override
  State<GuideHome> createState() => _GuideHomeState();
}

class _GuideHomeState extends State<GuideHome> {

  late GuideViewModel _guideViewModel;

  @override
  void initState() {
    super.initState();
    SpUtil.init().then((_) {
      _guideViewModel = context.getViewModel<GuideViewModel>();
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _guideViewModel.doPreWork());
    });
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> schoolMotto1TextList = [];
    List<Widget> schoolMotto2TextList = [];
    schoolMotto1TextList.addAll(StringAssets.schoolMotto1.split('')
        .map((char) => _guideText(char)).toList());
    schoolMotto1TextList.add(const SizedBox(height: 70));
    schoolMotto2TextList.add(const SizedBox(height: 70));
    schoolMotto2TextList.addAll(StringAssets.schoolMotto2.split('')
        .map((char) => _guideText(char)).toList());
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: schoolMotto1TextList
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: schoolMotto2TextList
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    ImageAssets.logo,
                    width: 60,
                    height: 60,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  StringAssets.appName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ));
  }

  /// 开屏引导页文字
  ///
  /// [text] 文字内容
  Text _guideText(String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic));
  }
}

