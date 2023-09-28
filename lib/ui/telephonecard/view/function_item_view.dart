import 'package:flutter/material.dart';

/// 功能BarItemView
///
/// @author wk
/// @since 2023/9/27
/// @version V1.8.8
class FunctionItemView extends StatelessWidget {
  const FunctionItemView(
      {super.key,
      required this.label,
      required this.path,
      required this.tapCallback});

  /// 功能名
  final String label;

  /// 功能图标路径
  final String path;

  /// 点击功能回调
  final Function tapCallback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Image.asset(
                path,
                width: 24,
                height: 24,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(label),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
          onTap: () {
            tapCallback();
          },
        ));
  }
}
