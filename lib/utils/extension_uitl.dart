import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// String的自定义扩展函数
///
/// @author zzp
/// @since 2023/9/16
extension StringExtension on String {

  /// toast
  void showToast() {
   SmartDialog.showToast(this, maskColor: Colors.black45);
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

extension StringNullExtension on String? {

  /// 若为null则返回空字符串
  String orEmpty() {
    return this ?? StringAssets.emptyStr;
  }
}

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