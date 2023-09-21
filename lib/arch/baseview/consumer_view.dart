import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/utils/extension_uitl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 监听整个model变化的view
///
/// @author zzp
/// @since 2023/9/12
/// @version v1.8.8
class ConsumerView<T extends BaseViewModel> extends StatefulWidget {
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
  final Function(T)? onInit;
  /// 销毁时
  final Function(T)? onDispose;

  @override
  State<ConsumerView> createState() => _ConsumerViewState<T>();
}

class _ConsumerViewState<T extends BaseViewModel>
    extends State<ConsumerView<T>> {

  @override
  void initState() {
    super.initState();
    T viewModel = context.readViewModel<T>();
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.onInit?.call(viewModel));
  }

  @override
  void dispose() {
    super.dispose();
    T viewModel = context.read<T>();
    widget.onDispose?.call(viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
        builder: widget.builder,
        child: widget.child,
    );
  }
}
