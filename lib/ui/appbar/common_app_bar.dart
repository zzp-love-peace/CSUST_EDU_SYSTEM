import 'package:flutter/material.dart';

/// 通用AppBar
///
/// @author zzp
/// @since 2023/9/21
/// @version v1.8.8
class CommonAppBar {
  /// 创建通用AppBar
  static AppBar create(String text,
      {List<Widget>? actions, Widget? leading, PreferredSizeWidget? bottom}) {
    return AppBar(
      elevation: 0,
      foregroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottom: bottom,
      actions: actions,
      leading: leading,
    );
  }
}
