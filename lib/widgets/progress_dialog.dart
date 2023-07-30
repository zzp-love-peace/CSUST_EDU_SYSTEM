import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../data/date_info.dart';
import 'hint_dialog.dart';

class ProgressDialog extends StatefulWidget {
  final Function progressFun;

  const ProgressDialog(this.progressFun, {Key? key}) : super(key: key);

  @override
  State<ProgressDialog> createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  double _value = 0.0;
  int _nowWeekNum = 1;

  @override
  void initState() {
    super.initState();
    _doProgress();
  }

  _doProgress() async {
    int i;
    for (i = 1; i <= DateInfo.totalWeek; i++) {
      var result = await widget.progressFun(i, isDialog: false);
      if (result) {
        setState(() {
          _value = i / DateInfo.totalWeek;
          _nowWeekNum = i;
        });
      } else {
        break;
      }
    }
    SmartDialog.dismiss();
    String helpText;
    if (i > DateInfo.totalWeek) {
      helpText = '刷新成功，下次打开app时生效';
    } else {
      helpText = '获取第$i周的课表失败了';
    }
    SmartDialog.compatible.show(
        widget: HintDialog(
          title: '提示',
          subTitle: helpText,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('加载中',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: LinearProgressIndicator(
                      value: _value,
                    ),
                  ),
                  RichText(text: TextSpan(text: _nowWeekNum.toString(), style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,), children: [
                    TextSpan(text: '/${DateInfo.totalWeek}', style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,))
                  ]),),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ))
        ]));
  }
}
