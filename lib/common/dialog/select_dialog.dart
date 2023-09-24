import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 选择Dialog
///
/// @author zzp
/// @since 2023/9/24
/// @version v1.8.8
class SelectDialog extends StatelessWidget {
  const SelectDialog(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.callback,
      this.positiveText = StringAssets.ok,
      this.negativeText = StringAssets.cancel})
      : super(key: key);

  /// 标题
  final String title;

  /// 副标题
  final String subTitle;

  /// 确定回调
  final Function callback;

  /// 确定按钮text
  final String positiveText;

  /// 取消按钮text
  final String negativeText;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Padding(padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Text(
                          subTitle, style: const TextStyle(color: Colors.black)),),
                    const Divider(
                      thickness: 2,
                      height: 0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            child: Text(
                              negativeText,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme
                                      .of(context)
                                      .primaryColor),
                            ),
                            onPressed: () {
                              SmartDialog.dismiss();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                          child: VerticalDivider(
                            thickness: 2,
                            width: 8,
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: TextButton(
                              child: Text(
                                positiveText,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme
                                        .of(context)
                                        .primaryColor),
                              ),
                              onPressed: () {
                                callback();
                                SmartDialog.dismiss();
                              },
                            ))
                      ],
                    )
                  ],
                )),
          ],)
    );
  }
}
