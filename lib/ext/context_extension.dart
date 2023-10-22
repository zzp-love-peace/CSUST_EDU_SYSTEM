import 'package:csust_edu_system/common/theme/viewmodel/theme_view_model.dart';
import 'package:csust_edu_system/util/route/fade_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../arch/basedata/page_result_bean.dart';
import '../arch/baseviewmodel/base_view_model.dart';
import '../ass/key_assets.dart';
import '../ass/string_assets.dart';
import '../util/sp/sp_util.dart';

/// BuildContext的自定义扩展函数
///
/// @author zzp
/// @since 2023/9/19
/// @version v1.8.8
extension BuildContextExtension on BuildContext {
  /// 初始化主题色
  void initThemeColor() {
    var nowColor = SpUtil.get(KeyAssets.color, StringAssets.blue);
    var themeViewModel = read<ThemeViewModel>();
    if (themeViewModel.model.themeColorKey != nowColor) {
      // 设置初始化主题颜色
      themeViewModel.setThemeColor(nowColor);
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

  /// 带有显隐动效的跳转
  ///
  /// [page] 页面
  void pushWithFadeRoute(Widget page) {
    Navigator.of(this).push(FadeRoute(page: page));
  }

  /// 回退页面
  ///
  /// [result] 返回值
  void pop<T>({PageResultBean<T>? result}) {
    Navigator.pop(this, result);
  }
}
