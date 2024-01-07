import 'package:csust_edu_system/ass/string_assets.dart';

import '../../../ass/key_assets.dart';
import '../../../common/picker/common_picker.dart';
import '../../../util/sp/sp_util.dart';

/// 个人资料model
///
/// @author wk
/// @since 2023/11/22
/// @version v1.8.8
class StuInfoModel {
  StuInfoModel(
      {required this.userName, required this.sex, required this.avatar});

  /// 更改的头像图片路径
  String imagePath = StringAssets.emptyStr;

  ///  昵称
  String userName;

  ///  性别
  bool sex;

  ///  头像
  String avatar;

  ///  总绩点
  double totalPoint = SpUtil.get<double>(KeyAssets.totalPoint, 0);

  ///  是否可以保存
  bool enable = false;

  /// 性别选择器
  final sexPicker = CommonPicker<String>();

  /// 选择器当前索引
  int pickerIndex = 0;

  /// 性别列表
  final List<String> sexList = [StringAssets.man, StringAssets.woman];
}
