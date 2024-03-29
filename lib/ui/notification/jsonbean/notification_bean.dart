import 'package:csust_edu_system/ass/key_assets.dart';

/// 通知类Bean
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.19
class NotificationBean {
  NotificationBean.fromJson(Map<String, dynamic> json)
      : id = json[KeyAssets.id],
        content = json[KeyAssets.notificationContent],
        createTime = json[KeyAssets.createTime];

  /// 通知id
  int id;

  /// 内容
  String content;

  /// 创建时间
  String createTime;
}
