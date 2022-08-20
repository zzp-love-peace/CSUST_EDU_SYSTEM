class DateInfo {
  // 现在的学期
  static String nowTerm = "";

  // 今天的日期
  static String nowDate = "";

  // 今天是第几周
  static int nowWeek = -1;

  // 一共有几周
  static int totalWeek = 0;

  static initData(Map dateData) {
    nowTerm = dateData['nowXueqi'];
    nowDate = dateData['nowDate'];
    nowWeek = dateData['nowWeek'];
    totalWeek = dateData['totalWeek'];
  }
}
