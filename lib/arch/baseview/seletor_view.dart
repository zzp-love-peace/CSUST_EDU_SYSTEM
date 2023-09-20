import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 选择性监听model中某一属性的view
///
/// @author zzp
/// @since 2023/9/12
/// @version v1.8.8
class SelectorView<T extends ChangeNotifier, K> extends StatefulWidget {
  const SelectorView(
      {super.key,
        required this.selector,
        required this.builder,
        this.child,
        this.onInit,
        this.onDispose});

  /// 选择器
  final K Function(BuildContext context, T value) selector;
  /// 构造器
  final Widget Function(BuildContext context, K value, Widget? child) builder;
  /// 子view
  final Widget? child;
  /// 初始化时
  final Function()? onInit;
  /// 销毁时
  final Function()? onDispose;

  @override
  State<SelectorView> createState() => _SelectorViewState<T, K>();
}

class _SelectorViewState<T extends ChangeNotifier, K>
    extends State<SelectorView<T, K>> {
  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<T, K>(
      selector: widget.selector,
      builder: widget.builder,
      child: widget.child,
    );
  }
}