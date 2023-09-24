class CourseUtil {
  // 服务器返回的数据不适合GridView。。。所以必须得处理
  static List changeList(List list) {
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
      result.add(changeList(l));
    }
    return result;
  }

  static List analyzeCourseOfTerm(List data) {
    List allData = [];
    for (int i = 1; i <= 20; i++) {
      List dList = [];
      for (int j = 0; j < data.length; j++) {
        List ddList = [];
        for (int k = 0; k < data[j].length; k++) {
          Map? map = data[j][k];
          if (map == null) {
            ddList.add(null);
            continue;
          }
          bool flag = false;
          var sList = map['time'].toString().split(' ');
          for (var s in sList) {
            var s1 = s.split('(');
            if (s1[0].contains(',')) {
              var s2 = s1[0].split(',');
              for (var s3 in s2) {
                var s4 = s3.split('-');
                if (s4.length == 1) {
                  int i2 = int.parse(s4[0]);
                   if (i == i2) {
                     flag = true;
                   }
                } else {
                  int start = int.parse(s4[0]);
                  int end = int.parse(s4[1]);
                  if (i >= start && i <= end) {
                    flag = true;
                  }
                }
              }
            } else {
              var s2 = s1[0].split('-');
              int start = int.parse(s2[0]);
              int end = int.parse(s2[1]);
              if (i >= start && i <= end) {
                flag = true;
              }
            }
          }
          if (!flag) {
            ddList.add(null);
          } else {
            ddList.add(data[j][k]);
          }
        }
        dList.add(ddList);
      }
      allData.add(dList);
    }
    return allData;
  }
}