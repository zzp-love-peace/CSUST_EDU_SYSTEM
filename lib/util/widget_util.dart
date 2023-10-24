import 'package:flutter/material.dart';

/// 组件工具类
///
/// @author zzp
/// @since 2023/10/24
/// @version v1.8.8
class WidgetUtil {
  /// 构建垂直方向显隐动效的widget
  ///
  /// [child] 子widget
  /// [animation] 动画
  static Widget buildFadeWidgetVertical(
    Widget child,
    Animation<double> animation,
  ) {
    return SlideTransition(
        position:
            Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0))
                .animate(animation),
        child: FadeTransition(
            opacity: animation,
            child: SizeTransition(
                axis: Axis.vertical, sizeFactor: animation, child: child)));
  }

  /// 构建水平方向显隐动效的widget
  ///
  /// [child] 子widget
  /// [animation] 动画
  static Widget buildFadeWidgetHorizontal(
    Widget child,
    Animation<double> animation,
  ) {
    return SlideTransition(
        position:
            Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
                .animate(animation),
        child: FadeTransition(
            opacity: animation,
            child: SizeTransition(
                axis: Axis.horizontal, sizeFactor: animation, child: child)));
  }
}
