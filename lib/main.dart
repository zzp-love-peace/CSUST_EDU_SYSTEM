import 'package:csust_edu_system/homes/guide_home.dart';
import 'package:csust_edu_system/provider/app_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/color_data.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SmartDialog.compatible.config
      .maskColor = Colors.black45;
    return ChangeNotifierProvider(
        create: (_) => AppInfoProvider(),
        child: Consumer<AppInfoProvider>(builder: (context, appInfo, _) {
          String colorKey = appInfo.themeColor;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: themeColorMap[colorKey] ?? Colors.blue,
              brightness: Brightness.light,
              cupertinoOverrideTheme: const CupertinoThemeData(
                  brightness: Brightness.light
              ),
            ),
            home: const GuideHome(),
            navigatorObservers: [FlutterSmartDialog.observer],
            builder: FlutterSmartDialog.init(),
          );
        } )
    );
  }
}
