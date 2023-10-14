import 'package:flutter/material.dart';

/// 电费页选择View
///
/// @author zzp
/// @since 2023/10/13
/// @version v1.8.8
class ElectricitySelectorView extends StatelessWidget {
  const ElectricitySelectorView(
      {super.key,
      required this.title,
      required this.content,
      required this.onTap,
      required this.paddingLeft});

  /// 标题
  final String title;

  /// 内容
  final String content;

  /// 内侧左边距
  final double paddingLeft;

  /// 点击事件回调
  final Function onTap;

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
        Expanded(
          child: GestureDetector(
            child: Padding(
              padding: EdgeInsets.fromLTRB(paddingLeft, 12, 0, 12),
              child: Text(
                content,
                style: TextStyle(
                    color: content.startsWith("点击选择")
                        ? Colors.black54
                        : Colors.black,
                    fontSize: 16),
              ),
            ),
            onTap: () {
              onTap.call();
            },
          ),
        )
      ],
    );
  }
}
