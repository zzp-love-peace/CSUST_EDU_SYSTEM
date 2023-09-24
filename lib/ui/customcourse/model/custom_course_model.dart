import 'package:flutter/cupertino.dart';

/// 自定义课程表Model
///
/// @author zzp
/// @since 2023/9/21
/// @version v1.8.8
class CustomCourseModel {
  CustomCourseModel();

  /// 课程名称输入控制器
  final courseNameController = TextEditingController();

  /// 授课老师输入控制器
  final teacherController = TextEditingController();

  /// 上课地点输入控制器
  final placeController = TextEditingController();
}
