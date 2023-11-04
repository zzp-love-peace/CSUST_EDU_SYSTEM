import 'package:csust_edu_system/ui/exam/jsonbean/exam_bean.dart';

/// 考试Model
///
/// @author wk
/// @since 2023/11/4
/// @version v1.8.8
class ExamModel {
  ExamModel({required this.term});

  /// 学期
  String term;

  /// 考试列表
  List<ExamBean> examList = [];
}
