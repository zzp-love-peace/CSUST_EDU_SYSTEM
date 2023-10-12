import 'package:date_format/date_format.dart';

import '../../../ass/image_assets.dart';
import '../../../ass/string_assets.dart';

/// 线上营业厅轮播图列表
const List<String> telephoneImgList = [
  ImageAssets.telephoneHall,
  ImageAssets.equity1,
  ImageAssets.equity2,
];

/// 电话卡业务——校区列表
const List<String> telephoneSchoolList = [
  StringAssets.JinPengRidge,
  StringAssets.Yuntang,
  StringAssets.mail,
];

/// 电话卡业务——套餐列表
const List<String> telephonePackageList = [
  StringAssets.package59,
  StringAssets.package28,
];

/// 获取当前日期
final String _now = formatDate(
    DateTime.now().add(const Duration(days: 1)), [yyyy, '-', mm, '-', dd, '-']);

/// 获取后一天日期
final String _tomorrow = formatDate(
    DateTime.now().add(const Duration(days: 2)), [yyyy, '-', mm, '-', dd, '-']);

/// 获取后两天日期
final String _bigTomorrow = formatDate(
    DateTime.now().add(const Duration(days: 3)), [yyyy, '-', mm, '-', dd, '-']);

/// 收卡时间段列表
final List<String> timeList = [
  _now + StringAssets.morning,
  _now + StringAssets.afternoon,
  _now + StringAssets.night,
  _tomorrow + StringAssets.morning,
  _tomorrow + StringAssets.afternoon,
  _tomorrow + StringAssets.night,
  _bigTomorrow + StringAssets.morning,
  _bigTomorrow + StringAssets.afternoon,
  _bigTomorrow + StringAssets.night,
];
