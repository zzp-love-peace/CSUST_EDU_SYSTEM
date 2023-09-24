import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:flutter/material.dart';

/// 保存按钮
///
/// @author zzp
/// @since 2023/9/21
/// @version v1.8.8
class SaveButtonView extends StatelessWidget {
  const SaveButtonView({super.key, required this.onPressed});

  /// 点击回调
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: const SizedBox(
          child: Center(
            child: Text(
              StringAssets.save,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          width: double.infinity,
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.fromLTRB(0, 10, 0, 10)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        ),
        onPressed: onPressed);
  }
}
