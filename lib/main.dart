import 'package:csust_edu_system/homes/guide_home.dart';
import 'package:csust_edu_system/provider/course_term_provider.dart';
import 'package:csust_edu_system/provider/theme_color_provider.dart';
import 'package:csust_edu_system/provider/unread_msg_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/color_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeColorProvider()),
      ChangeNotifierProvider(create: (_) => UnreadMsgProvider()),
      ChangeNotifierProvider(create: (_) => CourseTermProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SmartDialog.compatible.config.maskColor = Colors.black45;
    return Consumer<ThemeColorProvider>(builder: (context, appInfo, _) {
      String colorKey = appInfo.themeColor;
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // useMaterial3: true,
          primarySwatch: themeColorMap[colorKey] ?? Colors.blue,
          brightness: Brightness.light,
          cupertinoOverrideTheme:
          const CupertinoThemeData(brightness: Brightness.light),
        ),
        home: const GuideHome(),
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(builder: (context, widget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!);
        },),

      );
    });
  }
}

