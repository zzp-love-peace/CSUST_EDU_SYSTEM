import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/stu_info.dart';
import '../network/http_manager.dart';
import '../widgets/custom_toast.dart';
import '../widgets/select_dialog.dart';

const String version = 'v1.8.8';
const String appName = '新长理教务';

MaterialColor createMaterialColor(Color color) {
  List strengths = [.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;
  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1);
  }
  return MaterialColor(color.value, swatch);
}

String getAppSuffix() {
  String result = '';
  if (Platform.isAndroid) {
    result = '.apk';
  } else if (Platform.isIOS) {
    result = '.ipa';
  }
  return result;
}

@Deprecated('暂时废弃')
String addPrefixToUrl(String url) {
  var urlPrefix = 'http://qiniu.finalab.cn/';
  return url.startsWith('http') ? url : urlPrefix + url;
}

Widget buildFadeWidgetVertical(
    Widget child,
    Animation<double> animation,
    ) {
  return SlideTransition(
      position:
      Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0))
          .animate(animation),
      child: FadeTransition(
          opacity: animation,
          child: SizeTransition(
              axis: Axis.vertical, sizeFactor: animation, child: child)));
}

Widget buildFadeWidgetHorizontal(
    Widget child,
    Animation<double> animation,
    ) {
  return SlideTransition(
      position:
      Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
          .animate(animation),
      child: FadeTransition(
          opacity: animation,
          child: SizeTransition(
              axis: Axis.horizontal, sizeFactor: animation, child: child)));
}

checkVersion({bool isBegin = false}) {
  var form = '';
  if (Platform.isAndroid) {
    form = 'apk';
  } else if (Platform.isIOS) {
    form = 'ipa';
  } else {
    return;
  }
  HttpManager().getLastVersion(StuInfo.token, form).then((value) {
    if (value.isNotEmpty) {
      print('version $value');
     // value={"code": 200, "msg": "请求成功", "data": {"id": 34, "apkPath": "https://os3.eigeen.com/course-card/update/新长理教务v1.8.6.apk"," url": "https://os3.eigeen.com/course-card/update/新长理教务v1.8.7.apk", "info": "可以刷新整个学期课表了。圈子优化动画体验。", form: "apk", "flag": 2, "updateTime": "2023-08-12T16:51:48.000+00:00"}};
      if (value['code'] == 200) {
        String appPath = value['data']['apkPath'];
       // String appPath=" https://os3.eigeen.com/course-card/update/新长理教务v1.8.7.apk";
        var string = appPath.split(appName);
        var lastVersion = string[1].substring(0, string[1].length - 4);
        if (version.compareTo(lastVersion) >= 0) {
          if (!isBegin) {
            SmartDialog.compatible
                .showToast('', widget: const CustomToast('已经是最新版本了哦'));
          }
        } else {
          SmartDialog.compatible.show(
              widget: SelectDialog(
                  title: '有新版本',
                  subTitle: value['data']['info'],
                  positiveText: '现在更新',
                  negativeText: '以后再说',
                  callback: () async {
                    String url = form == 'apk'
                        ? appPath
                        : 'https://apps.apple.com/cn/app/%E9%95%BF%E7%90%86%E6%95%99%E5%8A%A1/id1619946564';
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                    }
                    else {
                      SmartDialog.compatible.showToast(
                          '', widget: const CustomToast('下载链接有误'));
                    }
                  }),
              clickBgDismissTemp: false);
        }
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