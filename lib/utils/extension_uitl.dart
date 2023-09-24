import 'package:csust_edu_system/arch/basedata/page_result_bean.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/utils/sp/sp_util.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import '../arch/baseviewmodel/base_view_model.dart';
import '../ass/key_assets.dart';
import '../provider/theme_color_provider.dart';

/// String的自定义扩展函数
///
/// @author zzp
/// @since 2023/9/16
/// @version v1.8.8
extension StringExtension on String {

  /// toast
  void showToast() {
    SmartDialog.showToast(this, builder: (_) => CustomToast(this));
  }

  /// 内容是否为空
  bool isBlank() {
    return trim().isEmpty;
  }

  /// 内容是否不为空
  bool isNotBlank() {
    return !isBlank();
  }
}

/// String？的自定义扩展函数
///
/// @author zzp
/// @since 2023/9/17
/// @version v1.8.8
extension StringNullExtension on String? {

  /// 若为null则返回空字符串
  String orEmpty() {
    return this ?? StringAssets.emptyStr;
  }
}

/// List<String>的自定义扩展函数
///
/// @author zzp
/// @since 2023/9/17
/// @version v1.8.8
extension StringList on List<String> {

  /// 是否数组内所有字符串内容都为空
  bool isAllNotBlank() {
    for(var str in this) {
      if (str.isBlank()) {
        return false;
      }
    }
    return true;
  }
}

/// BuildContext的自定义扩展函数
///
/// @author zzp
/// @since 2023/9/19
/// @version v1.8.8
extension BuildContextExtension on BuildContext {

  /// 初始化主题色
  void initThemeColor() {
    var nowColor = SpUtil.get(KeyAssets.color, StringAssets.blue);
    var themeColorProvider = Provider.of<ThemeColorProvider>(this, listen: false);
    if (themeColorProvider.themeColor != nowColor) {
      // 设置初始化主题颜色
      themeColorProvider.setTheme(nowColor);
    }
  }

  /// 获取ViewModel
  T readViewModel<T extends BaseViewModel>() {
    T res = read<T>();
    res.injectContext(this);
    return res;
  }

  /// 获取ViewModel，并使得该context监听model变化
  T watchViewModel<T extends BaseViewModel>() {
    T res = watch<T>();
    res.injectContext(this);
    return res;
  }

  /// 跳转（替换Page栈顶页面）
  ///
  /// [page] 页面
  void pushReplacement(Widget page) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  /// 跳转
  ///
  /// [page] 页面
  Future<PageResultBean<T>?> push<T>(Widget page) {
    return Navigator.of(this)
        .push<PageResultBean<T>>(MaterialPageRoute(builder: (_) => page));
  }

  /// 回退页面
  ///
  /// [result] 返回值
  void pop<T>({PageResultBean<T>? result}) {
    Navigator.pop(this, result);
  }
}