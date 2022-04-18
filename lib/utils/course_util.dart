class CourseUtil {
  // 服务器返回的数据不适合GridView。。。所以必须得处理
  static List _changeList(List list) {
    List<List<Map?>> result = [[], [], [], [], []];
    for (int j = 0; j < list.length; j++) {
      result[j].add(null);
      for (int i = 0; i < list[j].length; i++) {
        if (i == 0) {
          result[j].add(list[j][list[j].length - 1]);
        } else {
          result[j].add(list[j][i - 1]);
        }
      }
    }
    return result;
  }

  static List changeCourseDataList(List list) {
    List result = [];
    for (List l in list) {
      result.add(_changeList(l));
    }
    return result;
  }
}