import 'package:csust_edu_system/ass/key_assets.dart';

/// 兼职Bean类
///
/// @author zzp
/// @since 2023/10/27
/// @version v1.8.8
class RecruitBean {
  RecruitBean.fromJson(Map json)
      : title = json[KeyAssets.title],
        content = json[KeyAssets.content],
        workDate = json[KeyAssets.workDate],
        workTime = json[KeyAssets.workTime],
        contact = json[KeyAssets.contact],
        duty = json[KeyAssets.duty];

  /// 标题
  String title;

  /// 内容
  String content;

  /// 工作日期
  String workDate;

  /// 工作时间
  String workTime;

  /// 联系方式
  String contact;

  /// 免责声明
  String duty;
}
