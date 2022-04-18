import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class AboutHome extends StatelessWidget {
  const AboutHome({Key? key}) : super(key: key);

  final String _version = "内测版";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
              Text('版本号: $_version'),
              const SizedBox(
                height: 15,
              ),
              const Text('长理教务'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'https://github.com/zzp-love-peace/CSUST_EDU_SYSTEM',
                style: TextStyle(color: Colors.blueGrey, fontSize: 12),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                child: const Text(
                  '点我复制',
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
                onTap: () {
                  Clipboard.setData(const ClipboardData(text: 'https://github.com/zzp-love-peace/CSUST_EDU_SYSTEM'));
                  SmartDialog.showToast('', widget: const CustomToast('复制成功'));
                },
              ),
              const SizedBox(
                height: 18,
              ),
              const Text('本项目使用flutter开发且开源 欢迎star和fork'),
              const SizedBox(
                height: 25,
              ),
              const Text(
                '关于我们',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: Text(
                      '本app由长沙理工大学计通学院凡路实验室移动开发部20级部长开发，对app有任何的建议，都可以反馈给我们。非常期待您推荐给身边的同学。')),
              const Spacer(),
              const Text(
                'made in zzp',
                style: TextStyle(color: Colors.indigo),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }
}
