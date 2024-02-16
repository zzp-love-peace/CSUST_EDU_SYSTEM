import 'package:csust_edu_system/ui/grade/json/grade_bean.dart';

/// 成绩相关工具类
///
/// @author zzp
/// @since 2024/2/16
/// @version v1.8.8
class GradeUtil {
  /// 计算总绩点
  ///
  /// [gradeList] 成绩列表
  static double getSumPoint(List<GradeBean> gradeList) {
    if (gradeList.isEmpty) {
      return 0;
    } else {
      double sum = 0;
      double sumPointXScore = 0;
      for (var element in gradeList) {
        sum += double.parse(element.creditPoints);
        sumPointXScore +=
            (double.parse(element.creditPoints) * double.parse(element.point));
      }
      return sumPointXScore / sum;
    }
  }
}
