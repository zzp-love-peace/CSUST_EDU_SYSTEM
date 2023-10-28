import 'package:csust_edu_system/ass/string_assets.dart';

/// 日期相关工具类
///
/// @author zzp
/// @since 2023/10/26
/// @version v1.8.8
class DateUtil {
  /// 分割日期（将xxxx-xx-xx的日期格式分割成int）
  ///
  /// [date] 日期字符串
  static List<int> splitDate(String date) {
    if (date.isEmpty) {
      date = (DateTime.now().toString()).split(' ')[0];
    }
    List<String> dates = date.split('-');
    int year = int.parse(dates[0]);
    int month = int.parse(dates[1]);
    int day = int.parse(dates[2]);
    return [year, month, day];
  }

  /// 日期转星期（蔡勒公式计算星期几 0表示周日）
  ///
  /// [date] 日期字符串
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

  /// 获取本周日的日期（传入今天的日期 格式为xxx-xx-xx 返回本周日的年月日）
  ///
  /// [nowDate] 今日日期
  static List<int> getSunday(String nowDate) {
    var date = DateUtil.splitDate(nowDate);
    int dateOfWeek = DateUtil.date2Week(nowDate);
    return DateUtil.minusDay(date[0], date[1], date[2], dateOfWeek);
  }

  /// 计算某个日期的前num天
  ///
  /// [year] 年
  /// [month] 月
  /// [day] 日
  /// [num] 天数
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
      }
      day += n;
    }
    return day > 0 ? [year, month, day] : minusDay(year, month, day, 0);
  }

  /// 计算某个日期的后num天
  ///
  /// [year] 年
  /// [month] 月
  /// [day] 日
  /// [num] 天数
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
    }
    return d == day ? [year, month, day] : addDay(year, month, day, 0);
  }

  /// 下标转换为周几
  ///
  /// [index] 下标
  static String indexToWeekDay(int index) {
    String result = '';
    switch (index) {
      case 1:
        result = StringAssets.Sunday;
        break;
      case 2:
        result = StringAssets.Monday;
        break;
      case 3:
        result = StringAssets.Tuesday;
        break;
      case 4:
        result = StringAssets.Wednesday;
        break;
      case 5:
        result = StringAssets.Thursday;
        break;
      case 6:
        result = StringAssets.Friday;
        break;
      case 7:
        result = StringAssets.Saturday;
        break;
    }
    return result;
  }

  /// 格式化日期字符串
  ///
  /// [postDate] 日期字符串
  static String getForumDateString(String postDate) {
    var postDateTime = DateTime.parse(postDate);
    var nowDateTime = DateTime.now();
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
      return StringAssets.justNow;
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

  /// 获取当天与指定日期相差的天数
  ///
  /// [date] 日期
  static int getDiffDays(String date) {
    var dateTime = DateTime.parse(date);
    var nowDateTime = DateTime.now();
    var diffDateTime = nowDateTime.difference(dateTime);
    return diffDateTime.inDays;
  }
}
