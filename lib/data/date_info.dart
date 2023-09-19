import 'package:csust_edu_system/ass/string_assets.dart';
import '../ass/key_assets.dart';
import '../utils/sp/sp_util.dart';

class DateInfo {
  // 现在的学期
  static String nowTerm = "";

  // 今天的日期
  static String nowDate = "";

  // 今天是第几周
  static int nowWeek = -1;

  // 一共有几周
  static int totalWeek = 20;

  static initData(Map dateData) {
    nowTerm = dateData['nowXueqi'];
    nowDate = dateData['nowDate'];
    nowWeek = dateData['nowWeek'];
    totalWeek = dateData['totalWeek'];
  }

  /// 保存数据
  static void saveData() {
    SpUtil.put(KeyAssets.nowTerm, DateInfo.nowTerm);
    SpUtil.put(KeyAssets.nowDate, DateInfo.nowDate);
    SpUtil.put(KeyAssets.nowWeek, DateInfo.nowWeek);
    SpUtil.put(KeyAssets.totalWeek, DateInfo.totalWeek);
  }

  /// 从SharedPreferences中初始化数据
  static void initDataFromSp() {
    DateInfo.nowTerm = SpUtil.get<String>(KeyAssets.nowTerm, StringAssets.emptyStr);
    DateInfo.nowDate = SpUtil.get<String>(KeyAssets.nowDate, StringAssets.emptyStr);
    DateInfo.nowWeek = SpUtil.get<int>(KeyAssets.nowWeek, -1);
    DateInfo.totalWeek = SpUtil.get<int>(KeyAssets.totalWeek, 20);
  }
}
