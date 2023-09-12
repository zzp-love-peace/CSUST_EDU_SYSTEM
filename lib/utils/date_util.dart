class DateUtil {
  /// 将xxxx-xx-xx的日期格式分割成int
  static List<int> splitDate(String date) {
    if(date.isEmpty){
      date=(DateTime.now().toString()).split(' ')[0];
    }
    List<String> dates = date.split('-');
    int year = int.parse(dates[0]);
    int month = int.parse(dates[1]);
    int day = int.parse(dates[2]);
    return [year, month, day];
  }

  ///  蔡勒公式计算星期几 0表示周日
  static int date2Week(String date) {
    List<int> dates = splitDate(date);
    int year = dates[0];
    int c = year ~/ 100;
    int y = year % 100;
    int month = dates[1];
    if (month < 3) {
      month += 12;
      y--;
    }
    int day = dates[2];
    int w =
        ((c ~/ 4) - 2 * c + y + y ~/ 4 + ((13 * (month + 1)) ~/ 5) + day - 1) %
            7;
    return w;
  }

  static List<int> minusDay(int year, int month, int day, int num) {
    int n = 0;
    day -= num;
    if (day <= 0) {
      month--;
      if (month == 0) {
        month = 12;
        year--;
      }
      switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
          n = 31;
          break;
        case 4:
        case 6:
        case 9:
        case 11:
          n = 30;
          break;
        case 2:
          if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
            n = 29;
          } else {
            n = 28;
          }
          break;
        default:
          throw Exception('月份传错了');
      }
      day += n;
    }
    return day > 0 ? [year, month, day] : minusDay(year, month, day, 0);
  }

  static List<int> addDay(int year, int month, int day, int num) {
    day += num;
    int d = day;
    switch (month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        if (day > 31) {
          if (month == 12) {
            month = 1;
            year++;
          } else {
            month++;
          }
          day -= 31;
        }
        break;
      case 4:
      case 6:
      case 9:
      case 11:
        if (day > 30) {
          month++;
          day -= 30;
        }
        break;
      case 2:
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
          if (day > 29) {
            month++;
            day -= 29;
          }
        } else {
          if (day > 28) {
            month++;
            day -= 28;
          }
        }
        break;
      default:
        throw Exception('月份传错了');
    }
    return d == day ? [year, month, day] : addDay(year, month, day, 0);
  }

  static String indexToWeekDay(int index) {
    String result = '';
    switch (index) {
      case 1:
        result = '周日';
        break;
      case 2:
        result = '周一';
        break;
      case 3:
        result = '周二';
        break;
      case 4:
        result = '周三';
        break;
      case 5:
        result = '周四';
        break;
      case 6:
        result = '周五';
        break;
      case 7:
        result = '周六';
        break;
    }
    return result;
  }
}

String getForumDateString(String postDate) {
  var postDateTime = DateTime.parse(postDate);
  var nowDateTime = DateTime.now();
  // print('${nowDateTime.month}:${nowDateTime.day}');
  var diffDateTime = nowDateTime.difference(postDateTime);
  String minute;
  String hour;
  if (postDateTime.minute < 10) {
    minute = '0${postDateTime.minute}';
  } else {
    minute = postDateTime.minute.toString();
  }
  if (postDateTime.hour < 10) {
    hour = '0${postDateTime.hour}';
  } else {
    hour = postDateTime.hour.toString();
  }
  if (diffDateTime.inMinutes < 1) {
    return '刚刚';
  } else if (diffDateTime.inMinutes >= 1 && diffDateTime.inMinutes < 30) {
    return '${diffDateTime.inMinutes}分钟前';
  } else if (diffDateTime.inMinutes >= 30 && diffDateTime.inMinutes < 60) {
    return '半小时前';
  } else if (diffDateTime.inMinutes >= 60 && diffDateTime.inHours <= 10) {
    return '${diffDateTime.inHours}小时前';
  } else if (postDateTime.day == nowDateTime.day) {
    return '今天 $hour:$minute';
  } else if (nowDateTime.day == postDateTime.day + 1) {
    return '昨天 $hour:$minute';
  } else if (nowDateTime.day == postDateTime.day + 2) {
    return '前天 $hour:$minute';
  } else if (nowDateTime.day == postDateTime.day + 3) {
    return '大前天 $hour:$minute';
  } else if (nowDateTime.year == postDateTime.year) {
    return '${postDateTime.month}/${postDateTime.day} $hour:$minute';
  } else {
    return '${postDateTime.year} ${postDateTime.month}/${postDateTime.day} $hour:$minute';
  }
}
