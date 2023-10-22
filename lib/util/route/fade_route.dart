import 'package:flutter/cupertino.dart';

/// 显隐动效路由
///
/// @author zzp
/// @since 2023/10/22
/// @version v1.8.8
class FadeRoute extends PageRouteBuilder {
  /// 页面
  final Widget page;

  FadeRoute({required this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child
  ) => FadeTransition(opacity: animation, child: child,));

}