import 'package:flutter/material.dart';

import '../../../ass/string_assets.dart';

/// 电话卡提交按钮
///
/// @author wk
/// @since 2023/9/26
/// @version v1.8.8
class TelephoneButtonView extends StatelessWidget {
  const TelephoneButtonView({super.key, required this.onPress});

  /// 点击事件回调
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const SizedBox(
        child: Center(
          child: Text(
            StringAssets.commit,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        width: double.infinity,
      ),
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 10, 0, 10)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      ),
      onPressed: () {
        onPress.call();
      },
    );
  }
}
