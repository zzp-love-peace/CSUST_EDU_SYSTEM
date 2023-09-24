/// 课程表Item Model
///
/// @author zzp
/// @since 2023/9/23
/// @version v1.8.8
class CourseItemModel {
  CourseItemModel(
      {required this.courseName, required this.teacher, required this.place});

  /// 课程名称
  String courseName;

  /// 授课老师
  String teacher;

  /// 上课地点
  String place;
}
