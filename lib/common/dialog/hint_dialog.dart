import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'base_dialog.dart';

/// 提示Dialog
///
/// @author zzp
/// @since 2023/9/24
/// @version v1.8.8
class HintDialog extends StatelessWidget with BaseDialog {
  const HintDialog({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  /// 标题
  final String title;

  /// 副标题
  final String subTitle;

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
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(title,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
                        child: Text(subTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black)),
                      ),
                      Column(
                        children: [
                          const Divider(
                            thickness: 2,
                            height: 0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              child: Text(
                                StringAssets.ok,
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                              onPressed: () {
                                SmartDialog.dismiss();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ])
    );
  }
}
