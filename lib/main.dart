import 'package:csust_edu_system/arch/basedata/empty_model.dart';
import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/common/functionswicher/model/function_switcher_model.dart';
import 'package:csust_edu_system/common/functionswicher/viewmodel/function_switcher_view_model.dart';
import 'package:csust_edu_system/common/theme/model/theme_model.dart';
import 'package:csust_edu_system/common/theme/viewmodel/theme_view_model.dart';
import 'package:csust_edu_system/common/versionchecker/viewmodel/version_checker_view_model.dart';
import 'package:csust_edu_system/ui/guide/page/guide_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import 'ass/string_assets.dart';
import 'common/theme/data/theme_color_data.dart';
import 'common/unreadmsg/model/unread_msg_model.dart';
import 'common/unreadmsg/viewmodel/unread_msg_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => ThemeViewModel(
              model: ThemeModel(themeColorKey: StringAssets.blue))),
      ChangeNotifierProvider(
          create: (_) =>
              FunctionSwitcherViewModel(model: FunctionSwitcherModel())),
      ChangeNotifierProvider(
          create: (_) => UnreadMsgViewModel(model: UnreadMsgModel())),
      ChangeNotifierProvider(
          create: (_) => VersionCheckerViewModel(model: EmptyModel())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConsumerView<ThemeViewModel>(
      builder: (context, viewModel, _) {
        String colorKey = viewModel.model.themeColorKey;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: themeColorMap[colorKey] ?? Colors.blue,
            brightness: Brightness.light,
            cupertinoOverrideTheme:
                const CupertinoThemeData(brightness: Brightness.light),
          ),
          home: const GuidePage(),
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(
            builder: (context, widget) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!);
            },
          ),
        );
      },
    );
  }
}
