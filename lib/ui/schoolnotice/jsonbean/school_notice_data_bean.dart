import '../../../ass/key_assets.dart';

/// 学校通知数据Bean类
///
/// @author wk
/// @since 2023/9/22
/// @version v1.8.8
class SchoolNoticeDataBean {
  SchoolNoticeDataBean.fromJson(Map<String, dynamic> json)
      : htmlData = json[KeyAssets.data];

  /// html数据
  String htmlData;
}
