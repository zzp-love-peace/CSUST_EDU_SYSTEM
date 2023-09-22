import '../../../ass/key_assets.dart';

///学校通知Bean类
///
/// @author wk
/// @since 2023/9/22
/// @version v1.8.8
class SchoolNoticeBean {
  SchoolNoticeBean.fromJson(Map<String, dynamic> json)
      : htmlData = json[KeyAssets.data];

  /// 数据
  String htmlData;
}
