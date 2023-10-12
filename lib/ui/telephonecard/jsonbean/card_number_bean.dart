import '../../../ass/key_assets.dart';

/// 卡号类Bean
///
/// @author wk
/// @since 2023/9/28
/// @version v1.8.8
class CardNumberBean {
  CardNumberBean.fromJson(Map<String, dynamic> json)
      : mobile = json[KeyAssets.mobile],
        id = json[KeyAssets.id];

  /// 卡号
  String mobile;

  /// 卡号id
  int id;

  @override
  String toString() {
    return mobile;
  }
}
