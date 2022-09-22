import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/network/http_manager.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class AdviceHome extends StatefulWidget {
  const AdviceHome({Key? key}) : super(key: key);

  @override
  State<AdviceHome> createState() => _AdviceHomeState();
}

class _AdviceHomeState extends State<AdviceHome> {
  final _phoneController = TextEditingController();
  final _contentController = TextEditingController();

  bool _enable = false;

  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "反馈",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              maxLines: 1,
              maxLength: 11,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: "手机号",
                errorText: _error,
              ),
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty && _contentController.text.isNotEmpty) {
                    _enable = true;
                  } else {
                    _enable = false;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: TextField(
              controller: _contentController,
              keyboardType: TextInputType.text,
              minLines: 3,
              maxLines: 10,
              maxLength: 100,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: "意见或建议",
                errorText: null,
              ),
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty && _phoneController.text.isNotEmpty) {
                    _enable = true;
                  } else {
                    _enable = false;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: ElevatedButton(
              child: const Center(
                child: Text(
                  "提交",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              style: ButtonStyle(
                enableFeedback: _enable,
                backgroundColor: MaterialStateProperty.all(
                    _enable ? Theme.of(context).primaryColor : Colors.grey),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.fromLTRB(0, 10, 0, 10)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
              ),
              onPressed: () {
                if (_enable) {
                  RegExp exp = RegExp(
                      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
                  bool matched = exp.hasMatch(_phoneController.text);
                  if (matched) {
                    setState(() {
                      _error = null;
                    });
                    _addAdvice(_contentController.text, _phoneController.text);
                  } else {
                    setState(() {
                      _error = "手机号格式错误";
                    });
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  _addAdvice(String content, String phone) {
    HttpManager()
        .addAdvice(StuInfo.token, content, phone, StuInfo.name)
        .then((value) {
          if (value.isNotEmpty) {
            if (value['code'] == 200) {
              SmartDialog.compatible.showToast('', widget: const CustomToast('提交成功'));
              Future.delayed(const Duration(milliseconds: 1000),(){
                Navigator.of(context).pop();
              });
            } else {
              SmartDialog.compatible.showToast('', widget: CustomToast(value['msg']));
            }
          } else {
            SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了'));
          }
    }, onError: (_) {
      SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了'));
    });
  }
}
