import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../ass/string_assets.dart';
import '../common/dialog/custom_toast.dart';

/// String的自定义扩展函数
///
/// @author zzp
/// @since 2023/9/16
/// @version v1.8.8
extension StringExtension on String {
  /// toast
  void showToast() {
    var nowDateTime = DateTime.now();
    if (_StringToastHelper.lastToastDateTime == null ||
        this != _StringToastHelper.lastToast ||
        (this == _StringToastHelper.lastToast &&
            nowDateTime
                    .difference(_StringToastHelper.lastToastDateTime!)
                    .inSeconds >=
                5)) {
      SmartDialog.showToast(this, builder: (_) => CustomToast(this));
      _StringToastHelper.lastToast = this;
      _StringToastHelper.lastToastDateTime = nowDateTime;
    }
  }

  /// 内容是否为空
  bool isBlank() {
    return trim().isEmpty;
  }

  /// 内容是否不为空
  bool isNotBlank() {
    return !isBlank();
  }

  /// 添加webp后缀
  String suffixWebp() {
    return this + '/webp';
  }

  /// 添加thumb后缀
  String suffixThumb() {
    return this + '/thumb';
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
    for (var str in this) {
      if (str.isBlank()) {
        return false;
      }
    }
    return true;
  }
}

/// 字符串Toast辅助类
///
/// @author zzp
/// @since 2023/9/24
/// @version v1.8.8
class _StringToastHelper {
  /// 最近一次Toast的字符串
  static String lastToast = StringAssets.emptyStr;

  /// 最近一次Toast的时间
  static DateTime? lastToastDateTime;
}
