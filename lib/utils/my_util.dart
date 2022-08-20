import 'dart:io';
import 'package:flutter/material.dart';

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
    result = '.apk2';
  } else if (Platform.isIOS) {
    result = '.ipa';
  }
  return result;
}

String addPrefixToUrl(String url) {
  var urlPrefix = 'http://qiniu.finalab.cn/';
  return url.startsWith('http') ? url : urlPrefix + url;
}

Widget buildFadeWidget(
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
