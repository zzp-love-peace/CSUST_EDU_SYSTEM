import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 选择性监听model中某一属性的view
///
/// @author zzp
/// @since 2023/9/12
/// @version v1.8.8
class SelectorView<T extends BaseViewModel, K> extends StatefulWidget {
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
  final Function(T)? onInit;
  /// 销毁时
  final Function(T)? onDispose;

  @override
  State<SelectorView> createState() => _SelectorViewState<T, K>();
}

class _SelectorViewState<T extends BaseViewModel, K>
    extends State<SelectorView<T, K>> {
  /// viewModel实例
  late T viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.readViewModel<T>();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.onInit?.call(viewModel));
  }

  @override
  void dispose() {
    widget.onDispose?.call(viewModel);
    super.dispose();
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