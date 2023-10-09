import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/themecolor/page/theme_color_page.dart';
import 'package:flutter/material.dart';

import '../../../ass/string_assets.dart';
import '../../../common/dialog/hint_dialog.dart';
import '../../../common/dialog/select_dialog.dart';
import '../../../homes/about_home.dart';
import '../../advice/page/advice_page.dart';
import '../../login/page/login_page.dart';

/// 设置页
///
/// @author zzp
/// @since 2023/10/1
/// @version v1.8.8
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.create(StringAssets.setting),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              StringAssets.common,
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    leading: Icon(
                      Icons.color_lens,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: const Text(StringAssets.changeTheme),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      context.push(const ThemeColorPage());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    leading: Icon(Icons.cleaning_services,
                        color: Theme.of(context).primaryColor),
                    title: const Text(StringAssets.cleanAppCache),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      const HintDialog(
                              title: StringAssets.tips,
                              subTitle: StringAssets.cleanSuccess)
                          .showDialog();
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              StringAssets.other,
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    leading: Icon(
                      Icons.people,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: const Text(StringAssets.aboutUs),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      context.push(const AboutHome());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app,
                        color: Theme.of(context).primaryColor),
                    title: const Text(StringAssets.exitLogin),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      SelectDialog(
                        title: StringAssets.tips,
                        subTitle: StringAssets.sureExitLogin,
                        callback: () {
                          // 移除全部
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginPage()),
                              (Route router) => false);
                        },
                      ).showDialog();
                    },
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: TextButton(
              child: Text(
                StringAssets.haveQuestionOrAdvice,
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                context.push(const AdvicePage());
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
