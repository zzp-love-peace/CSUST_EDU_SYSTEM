import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/telephonecard/data/telephone_data.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 电话卡Model
///
/// @author wk
/// @since 2023/9/25
/// @version v1.8.8
class TelephoneModel {
  /// 电话卡轮播图列表
  final List<String> imgList = telephoneImgList;

  /// 创建日期格式对象

  /// 获取当前日期
  String now = formatDate(DateTime.now().add(const Duration(days: 1)),
      [yyyy, '-', mm, '-', dd, '-']);

  /// 获取后一天日期
  String tomorrow = formatDate(DateTime.now().add(const Duration(days: 2)),
      [yyyy, '-', mm, '-', dd, '-']);

  /// 获取后两天日期
  String bigTomorrow = formatDate(DateTime.now().add(const Duration(days: 3)),
      [yyyy, '-', mm, '-', dd, '-']);

  /// 收卡时间段列表
  List<String> timeList = [];

  /// 选择校区列表
  final List<String> schoolList = telephoneSchoolList;

  /// 套餐列表
  final List<String> packageList = telephonePackageList;

  /// 卡号列表
  final List<String> numberList = [];

  /// 校区
  String school = StringAssets.school;

  /// 套餐
  String package = StringAssets.package;

  /// 卡号
  String number = StringAssets.number;

  /// 卡号id
  int cardId = -1;

  /// 选卡时间
  String time = StringAssets.time;

  /// 姓名输入控制器
  final nameController = TextEditingController();

  /// 联系电话输入控制器
  final phoneNumberController = TextEditingController();

  /// 地址输入控制器
  final addressController = TextEditingController();
}
