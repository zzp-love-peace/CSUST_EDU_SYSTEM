import 'package:flutter/material.dart';

import '../jsonbean/custom_course_bean.dart';

/// 课程表Model
///
/// @author zzp
/// @since 2023/9/20
/// @version v1.8.8
class CourseModel {
  CourseModel({required this.weekNum, required this.term});

  /// 周数
  int weekNum;

  /// 学期
  String term;

  /// 周数选择器index
  final List<int> weekSelectedIndex = [];

  /// 自定义课程表list
  final List<CustomCourseBean> customCourseList = [];

  /// 页面控制器
  late PageController pageController = _initPageController();

  /// 初始化页面控制器
  PageController _initPageController() {
    return PageController(
      initialPage: weekNum - 1,
      keepPage: true,
    );
  }
}
