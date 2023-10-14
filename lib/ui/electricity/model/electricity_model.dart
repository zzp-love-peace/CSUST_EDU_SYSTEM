import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/picker/common_picker.dart';

/// 查电费Model
///
/// @author zzp
/// @since 2023/10/13
/// @version v1.8.8
class ElectricityModel {
  ElectricityModel(
      {this.schoolArea = StringAssets.emptyStr,
      this.schoolBuilding = StringAssets.emptyStr,
      this.result = StringAssets.emptyStr});

  /// 校区
  String schoolArea;

  /// 宿舍
  String schoolBuilding;

  /// 查询结果
  String result;

  /// 寝室号输入控制器
  final roomController = TextEditingController();

  /// 校区选择器
  final schoolAreaPicker = CommonPicker<String>();

  /// 宿舍楼选择器
  final schoolBuildingPicker = CommonPicker<String>();
}
