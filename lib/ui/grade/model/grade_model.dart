import '../json/grade_bean.dart';

/// 成绩Model
///
/// @author wk
/// @version V1.8.8
/// @since 2023/10/27
class GradeModel {
  GradeModel({required this.term});

  /// 总绩点
  double point = 0;

  /// 学期
  String term;


  /// 成绩列表
  List<GradeBean> gradeList = [];
}
