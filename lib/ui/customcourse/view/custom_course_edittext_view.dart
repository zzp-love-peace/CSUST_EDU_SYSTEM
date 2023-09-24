import 'package:flutter/material.dart';

/// 自定义课程表信息输入框
///
/// @author zzp
/// @since 2023/9/21
/// @version v1.8.8
class CustomCourseEditTextView extends StatelessWidget {
  const CustomCourseEditTextView(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.iconData,
      required this.iconColor});

  ///控制器
  final TextEditingController controller;

  /// 提示文字
  final String hintText;

  /// 图标
  final IconData iconData;

  /// 图标颜色
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 50,
        ),
        Icon(iconData, color: iconColor),
        const SizedBox(
          width: 25,
        ),
        Expanded(
            child: TextField(
          controller: controller,
          maxLines: 1,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
              hintText: hintText, hintStyle: const TextStyle(fontSize: 16)),
        )),
        const SizedBox(
          width: 50,
        ),
      ],
    );
  }
}
