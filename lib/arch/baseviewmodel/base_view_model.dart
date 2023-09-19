import 'package:flutter/material.dart';

/// 所有ViewModel基类
abstract class BaseViewModel<T> extends ChangeNotifier {
  BaseViewModel({required this.model});

  /// model数据
  T model;
  /// View的context
  late BuildContext context;

  /// 注入context
  ///
  /// [context] context
  void injectContext(BuildContext context) {
    this.context = context;
  }

  /// 设置model并更新
  /// [newModel] 新model
  void setModel(T newModel) {
    model = newModel;
    notifyListeners();
  }
}