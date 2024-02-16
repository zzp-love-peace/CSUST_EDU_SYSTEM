import 'package:csust_edu_system/ass/key_assets.dart';

/// 功能开关Bean类
///
/// @author zzp
/// @since 2024/2/16
/// @version v1.8.8
class FunctionSwitcherBean {
  FunctionSwitcherBean()
      : forum = true,
        serviceHall = false,
        partTimeJob = true;

  FunctionSwitcherBean.fromJson(Map<String, dynamic> json)
      : forum = json[KeyAssets.forum],
        serviceHall = json[KeyAssets.serviceHall],
        partTimeJob = json[KeyAssets.partTimeJob];

  /// 论坛
  bool forum;

  /// 线上营业厅
  bool serviceHall;

  /// 兼职
  bool partTimeJob;
}
