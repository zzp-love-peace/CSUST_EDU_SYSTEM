import 'package:csust_edu_system/arch/basedata/base_json_bean.dart';

import '../../../ass/key_assets.dart';

/// 卡号类Bean
///
/// @author wk
/// @since 2023/9/28
/// @version v1.8.8
class CarDNumberBean extends BaseJsonBean {
  CarDNumberBean.fromJson(Map<String, dynamic> json)
      : mobile = json[KeyAssets.mobile];

  String mobile;

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
