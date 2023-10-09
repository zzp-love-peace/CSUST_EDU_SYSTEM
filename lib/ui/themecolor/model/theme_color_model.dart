import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:flutter/material.dart';

/// 主题色Model
///
/// @author zzp
/// @since 2023/10/9
/// @version v1.8.8
class ThemeColorModel {
  ThemeColorModel();

  /// 单选按钮值
  String groupValue = StringAssets.emptyStr;

  /// 主题色list
  final List<MaterialColor> colors = [];

  /// 主题色名字list
  final List<String> colorNames = [];
}
