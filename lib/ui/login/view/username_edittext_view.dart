import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:flutter/material.dart';

/// 用户名输入框
///
/// @author zzp
/// @since 2023/9/12
class UsernameEditTextView extends StatelessWidget {
  const UsernameEditTextView({super.key, required this.controller});

  ///控制器
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLines: 1,
      maxLength: 12,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        labelText: StringAssets.stuId,
        errorText: null,
      ),
    );
  }
}
