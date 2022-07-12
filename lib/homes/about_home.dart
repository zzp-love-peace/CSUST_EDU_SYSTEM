import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class AboutHome extends StatelessWidget {
  const AboutHome({Key? key}) : super(key: key);

  final String _version = 'v1.2.8';
  final String _url = 'https://github.com/zzp-love-peace/CSUST_EDU_SYSTEM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
              Text('版本号: $_version'),
              const SizedBox(
                height: 15,
              ),
              const Text('长理教务'),
              const SizedBox(
                height: 15,
              ),
              Text(
                _url,
                style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                child: Text(
                  '点我复制',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, decoration: TextDecoration.underline),
                ),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: _url));
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
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Column(
                  children: const [
                    Text('本app由长沙理工大学计通学院凡路实验室移动开发部20级部长兼IOS俱乐部成员开发，'
                        '对app有任何的建议，都可以反馈给我们。非常期待您推荐给身边的同学。'),
                    SizedBox(height: 15,),
                    Text(
                      '意见反馈',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 10,),
                    Text('欢迎加入app交流群：955731766'),
                    Text('或联系2055984287@qq.com')
                  ],
                ),
              ),
              const Spacer(),
              const Text(
                'made by zzp',
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
