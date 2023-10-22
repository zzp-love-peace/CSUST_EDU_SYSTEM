import 'package:csust_edu_system/ass/string_assets.dart';

import '../ass/key_assets.dart';
import '../util/sp/sp_util.dart';

/// 日期相关信息类
///
/// @author zzp
/// @since 2023/10/22
/// @version v1.8.8
class DateInfo {
  /// 当前学期
  static String nowTerm = "";

  /// 当天日期
  static String nowDate = "";

  /// 当前周数
  static int nowWeek = -1;

  /// 总周数
  static int totalWeek = 20;

  /// 初始化数据
  ///
  /// [dateData] 日期相关json数据
  static initData(Map dateData) {
    nowTerm = dateData[KeyAssets.nowXueqi];
    nowDate = dateData[KeyAssets.nowDate];
    nowWeek = dateData[KeyAssets.nowWeek];
    totalWeek = dateData[KeyAssets.totalWeek];
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
