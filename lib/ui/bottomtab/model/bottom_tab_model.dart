import 'package:flutter/cupertino.dart';

/// 底部导航栏Model类
///
/// @author zzp
/// @since 2023/9/19
/// @version v1.8.8
class BottomTabModel {
  BottomTabModel({this.currentIndex = 0, required this.pages});

  /// 当前页面index
  int currentIndex;
  /// 页面列表
  List<Widget> pages;
}