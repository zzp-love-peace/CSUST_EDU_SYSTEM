import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 监听整个model变化的view
class ConsumerView<T extends ChangeNotifier> extends StatefulWidget {
  const ConsumerView(
      {super.key,
      required this.builder,
      this.child,
      this.onInit,
      this.onDispose});

  /// 构造器
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  /// 子view
  final Widget? child;
  /// 初始化时
  final Function()? onInit;
  /// 销毁时
  final Function()? onDispose;

  @override
  State<ConsumerView> createState() => _ConsumerViewState<T>();
}

class _ConsumerViewState<T extends ChangeNotifier>
    extends State<ConsumerView<T>> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.onInit?.call());
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
        builder: widget.builder,
        child: widget.child,
    );
  }
}
