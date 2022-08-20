import 'package:csust_edu_system/homes/about_home.dart';
import 'package:csust_edu_system/homes/advice_home.dart';
import 'package:csust_edu_system/homes/theme_home.dart';
import 'package:csust_edu_system/widgets/hint_dialog.dart';
import 'package:csust_edu_system/widgets/select_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'login_home.dart';

class SettingHome extends StatelessWidget {
  const SettingHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "设置",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              '通用',
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
                    title: const Text('更换主题'),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ThemeHome()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    leading: Icon(Icons.cleaning_services,
                        color: Theme.of(context).primaryColor),
                    title: const Text('清理应用缓存'),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      SmartDialog.compatible.show(
                          widget:
                              const HintDialog(title: '提示', subTitle: '清理成功！'));
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
              '其他',
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
                    title: const Text('关于我们'),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                          builder: (context) => const AboutHome()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app,
                        color: Theme.of(context).primaryColor),
                    title: const Text('退出登录'),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      SmartDialog.compatible.show(
                          widget: SelectDialog(
                            title: '提示',
                            subTitle: '确定要退出登录吗？',
                            callback: () {
                              // 移除全部
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginHome()),
                                  (Route router) => false);
                            },
                          ),
                          clickBgDismissTemp: false);
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
                '有问题或建议？',
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AdviceHome()));
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
