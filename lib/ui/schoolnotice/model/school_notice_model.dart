import 'package:csust_edu_system/ass/string_assets.dart';

/// 学校通知Model类
///
/// @author wk
/// @since 2023/9/22
/// @version v1.8.8
class SchoolNoticeModel {
  SchoolNoticeModel({required this.ggid, this.html = StringAssets.emptyStr});

  /// 学校通知id
  final String ggid;

  /// 学校通知data
  String html;
}
