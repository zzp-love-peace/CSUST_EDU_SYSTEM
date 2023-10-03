import '../../../ass/key_assets.dart';

/// 卡号类Bean
///
/// @author wk
/// @since 2023/9/28
/// @version v1.8.8
class CardNumberBean {
  CardNumberBean.fromJson(Map<String, dynamic> json)
      : id = json[KeyAssets.id],
        mobile = json[KeyAssets.mobile];

  String mobile;
  int id;
}
