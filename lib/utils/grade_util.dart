double getSumPoint(List gradeList) {
  double sum = 0;
  double sumPointXScore = 0;
  for (var element in gradeList) {
    sum += double.parse(element['xuefen']);
    sumPointXScore +=
    (double.parse(element['xuefen']) * double.parse(element['point']));
  }
  return sumPointXScore / sum;
}