import 'package:csust_edu_system/ass/key_assets.dart';

/// 教务通知Bean类
///
/// @author zzp
/// @since 2023/10/1
/// @version v1.8.8
class SchoolNoticeBean {
  SchoolNoticeBean.fromJson(Map<String, dynamic> json)
      : ggid = json[KeyAssets.ggid],
        title = json[KeyAssets.title],
        time = json[KeyAssets.time];

  /// 公告id
  String ggid;

  /// 标题
  String title;

  /// 时间
  String time;
}
