import 'package:flutter/material.dart';

/// 电话卡信息输入框
///
/// @author wk
/// @since 2023/9/26
/// @version v1.8.8
class TelephoneEditView extends StatelessWidget {
  const TelephoneEditView(
      {super.key,
      required this.controller,
      required this.title,
      required this.size,
      required this.hint});

  /// 输入框控制器
  final TextEditingController controller;

  /// 输入标题
  final String title;

  /// 输入框前sizedBox大小
  final double size;

  /// 输入框hint
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 30,
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        SizedBox(
          width: size,
        ),
        Expanded(
            child: TextField(
          controller: controller,
          maxLines: 1,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
              hintText: hint, hintStyle: const TextStyle(fontSize: 16)),
        )),
        const SizedBox(
          width: 30,
        ),
      ],
    );
  }
}
