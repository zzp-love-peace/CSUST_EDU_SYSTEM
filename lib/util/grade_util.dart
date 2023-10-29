import 'package:csust_edu_system/ui/grade/json/grade_bean.dart';

double getSumPoint(List<GradeBean> gradeList) {
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
