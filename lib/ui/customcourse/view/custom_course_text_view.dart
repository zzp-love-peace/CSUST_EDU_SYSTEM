import 'package:flutter/material.dart';

/// 自定义课程表信息文字
///
/// @author zzp
/// @since 2023/9/21
/// @version v1.8.8
class CustomCourseTextView extends StatelessWidget {
  const CustomCourseTextView(
      {super.key,
      required this.text,
      required this.iconData,
      required this.iconColor});

  /// 文字内容
  final String text;

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
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}
