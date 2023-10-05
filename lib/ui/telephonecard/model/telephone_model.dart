import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 电话卡Model
///
/// @author wk
/// @since 2023/9/25
/// @version v1.8.8
class TelephoneModel {

  /// 校区
  String school = StringAssets.clickSelectSchool;

  /// 套餐
  String package = StringAssets.clickSelectSchool;

  /// 卡号
  String number = StringAssets.clickSelectCardNumber;

  /// 卡号id
  int cardId = -1;

  /// 选卡时间
  String time = StringAssets.clickSelectCardReceivingTime;

  /// 姓名输入控制器
  final nameController = TextEditingController();

  /// 联系电话输入控制器
  final phoneNumberController = TextEditingController();

  /// 地址输入控制器
  final addressController = TextEditingController();
}
