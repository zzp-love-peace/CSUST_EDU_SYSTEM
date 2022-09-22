import 'dart:io';

import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/network/http_manager.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:csust_edu_system/widgets/select_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/my_util.dart';

class AboutHome extends StatelessWidget {
  const AboutHome({Key? key}) : super(key: key);

  // final String _url = 'https://github.com/zzp-love-peace/CSUST_EDU_SYSTEM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "关于",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
                  'assets/images/logo.png',
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('版本号: $version'),
              const SizedBox(
                height: 15,
              ),
              const Text('长理教务'),
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
                    checkVersion();
                  },
                  child: const Text(
                    '检查更新',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  )),
              Card(
                margin: const EdgeInsets.fromLTRB(24, 15, 24, 15),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  children: const [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      '关于我们',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(24, 12, 24, 20),
                      child: Text('本app由长沙理工大学计通学院凡路实验室移动开发部20级部长兼IOS俱乐部成员开发，'
                          '对app有任何的建议，都可以反馈给我们。非常期待您推荐给身边的同学。'),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'made by zzp',
                style: TextStyle(color: Theme
                    .of(context)
                    .primaryColor),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }
}
