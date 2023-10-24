import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:flutter/material.dart';

/// 所有ViewModel基类
///
/// @author zzp
/// @since 2023/9/12
/// @version v1.8.8
abstract class BaseViewModel<T, W extends BaseService> extends ChangeNotifier {
  BaseViewModel({required this.model});

  /// model数据
  T model;

  /// context
  late final BuildContext context = _context!;

  /// 实际的context
  BuildContext? _context;

  /// 用与网络请求的Service
  late W? service = createService();

  /// 子ViewModel仓库
  final Map<dynamic, BaseViewModel> _store = {};

  /// 注入context
  ///
  /// [context] context
  void injectContext(BuildContext context) {
    _context ??= context;
  }

  /// 创建Service
  W? createService();

  /// 设置model并更新
  ///
  /// [newModel] 新model
  void setModel(T newModel) {
    model = newModel;
    notifyListeners();
  }

  /// 注册子ViewModel
  ///
  /// [key] 键
  /// [sonViewModel] 子ViewModel
  void registerSonViewModel(dynamic key, BaseViewModel sonViewModel) {
    _store[key] = sonViewModel;
  }

  /// 反注册子ViewModel
  ///
  /// [key] 键
  void unregisterSonViewModel(dynamic key) {
    _store.remove(key);
  }

  /// 读取子ViewModel
  ///
  /// [key] 键
  V? readSonViewModel<V extends BaseViewModel>(dynamic key) {
    if (_store[key] is V) {
      return _store[key] as V;
    }
    return null;
  }
}
