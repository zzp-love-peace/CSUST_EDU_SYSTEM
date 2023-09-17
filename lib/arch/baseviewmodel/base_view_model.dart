import 'package:flutter/material.dart';

/// 所有ViewModel基类
abstract class BaseViewModel<T> extends ChangeNotifier {
  BaseViewModel({required this.model});

  /// model数据
  T model;

  /// 设置model并更新
  /// [newModel] 新model
  void setModel(T newModel) {
    model = newModel;
    notifyListeners();
  }
}