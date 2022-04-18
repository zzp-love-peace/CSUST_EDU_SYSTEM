import 'dart:convert';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/homes/about_home.dart';
import 'package:csust_edu_system/homes/login_home.dart';
import 'package:csust_edu_system/network/network.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:csust_edu_system/widgets/hint_dialog.dart';
import 'package:csust_edu_system/widgets/select_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class MinePage extends StatelessWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _minePageAppBar(),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          const _HeadImageRow(),
          const SizedBox(height: 10),
          _divider(),
          _infoCard(),
          _divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: _BottomButton(
              '关于',
              buttonColor: Colors.redAccent,
              callback: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AboutHome()));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: _BottomButton(
              '退出登录',
              callback: () {
                SmartDialog.show(
                    widget: SelectDialog(
                      title: '提示',
                      subTitle: '确定要退出登录吗？',
                      callback: () {
                        SmartDialog.dismiss();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginHome()));
                      },
                    ),
                    clickBgDismissTemp: false);
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _minePageAppBar() {
    return AppBar(
      actions: [
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 5, 10),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    "意见反馈",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.message,
                    size: 16,
                  ),
                ],
              ),
              onTap: () {
                SmartDialog.show(
                    widget: const HintDialog(
                        title: '提示',
                        subTitle: '若有任何意见或建议，请联系2055984287@qq.com'),
                    clickBgDismissTemp: false);
              },
            ))
      ],
      centerTitle: true,
      title: const Text(
        "我的",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Divider _divider() {
    return const Divider(
      indent: 20,
      endIndent: 20,
      thickness: 1,
      color: Colors.black45,
    );
  }

  Card _infoCard() {
    return Card(
      elevation: 10,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      color: Colors.white70,
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            '学籍档案',
            style: TextStyle(fontSize: 18),
          ),
          const Divider(
            height: 20,
            indent: 50,
            endIndent: 50,
            thickness: 1,
            color: Colors.black45,
          ),
          _collegeRow(),
          const SizedBox(height: 10),
          _majorRow(),
          const SizedBox(height: 10),
          _classRow(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Row _collegeRow() {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Image.asset(
          'assets/images/college.png',
          color: Colors.black54,
          height: 32,
          width: 32,
        ),
        const SizedBox(
          width: 30,
        ),
        const Expanded(
          child:
              Text('学院', style: TextStyle(fontSize: 16, color: Colors.black87)),
          flex: 1,
        ),
        Expanded(
          child: Text(
            StuInfo.college,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          flex: 3,
        )
      ],
    );
  }

  Row _majorRow() {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        Image.asset(
          'assets/images/major.png',
          color: Colors.black54,
          height: 32,
          width: 32,
        ),
        const SizedBox(
          width: 30,
        ),
        const Expanded(
          child:
              Text('专业', style: TextStyle(fontSize: 16, color: Colors.black87)),
          flex: 1,
        ),
        Expanded(
          child: Text(
            StuInfo.major,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          flex: 3,
        )
      ],
    );
  }

  Row _classRow() {
    return Row(
      children: [
        const SizedBox(
          width: 20,
        ),
        const Icon(
          Icons.people_outline_outlined,
          size: 36,
          color: Colors.black54,
        ),
        const SizedBox(
          width: 30,
        ),
        const Expanded(
          child:
              Text('班级', style: TextStyle(fontSize: 16, color: Colors.black87)),
          flex: 1,
        ),
        Expanded(
          child: Text(
            StuInfo.className,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          flex: 3,
        )
      ],
    );
  }
}

class _HeadImageRow extends StatefulWidget {
  const _HeadImageRow({Key? key}) : super(key: key);

  @override
  State<_HeadImageRow> createState() => _HeadImageRowState();
}

class _HeadImageRowState extends State<_HeadImageRow> {
  String? _base64String;

  @override
  void initState() {
    super.initState();
    _setHeadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 30,
        ),
        _base64String == null
            ? const SizedBox(
                height: 100,
                width: 100,
                child: Text(
                  '?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 85,
                      color: Colors.blue),
                ),
              )
            : ClipOval(
                child: Image.memory(
                const Base64Decoder().convert(_base64String!),
                height: 100,
                width: 100,
              )),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StuInfo.name,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              StuInfo.stuId,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        )
      ],
    );
  }

  _setHeadImage() {
    HttpManager().getHeadImage(StuInfo.cookie, StuInfo.token).then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          setState(() {
            _base64String = value['data'];
          });
        }
      } else {
        if (kDebugMode) {
          print('加载头像时出现异常了');
        }
        // SmartDialog.showToast('', widget: const CustomToast('加载头像时出现异常了'));
      }
    });
  }
}

class _BottomButton extends StatelessWidget {
  final String _text;
  final Color buttonColor;
  final void Function() callback;

  const _BottomButton(this._text,
      {Key? key, this.buttonColor = Colors.blue, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          callback();
        },
        child: Text(
          _text,
          style: const TextStyle(fontSize: 16),
        ),
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.fromLTRB(0, 10, 0, 10)),
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))))),
      ),
    );
  }
}
