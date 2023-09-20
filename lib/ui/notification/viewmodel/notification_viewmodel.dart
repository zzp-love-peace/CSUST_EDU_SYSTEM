import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/image_assets.dart';
import 'package:csust_edu_system/jsonbean/notification_bean.dart';
import 'package:csust_edu_system/ui/notification/model/notification_model.dart';
import 'package:csust_edu_system/ui/notification/service/notification_service.dart';
import 'package:flutter/material.dart';
import '../../../utils/date_util.dart';

/// 系统通知View model
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.19
class NotificationViewModel extends BaseViewModel<NotificationModel> {
  NotificationViewModel({required super.model});
  // 通知Service
  final NotificationService _service = NotificationService();
  // 初始化通知页面数据 -> 抓取信息，生成通知item并装入List
  void initNotificationPageData() {
    _service.getNotifications(onDataSuccess: (data, msg) {
      List notifications = data;
      if (notifications.isNotEmpty) {
          for (var notification in notifications) {
            var notificationJson = NotificationBean.fromJson(notification);
            model.notificationList.add(Container(
                color: Colors.white,
                child: ListTile(
                  leading: ClipOval(
                    child: Image.asset(
                      ImageAssets.logo,
                      width: 36,
                      height: 36,
                    ),
                  ),
                  title: Text(notificationJson.content),
                  trailing: Text(
                    getForumDateString(notificationJson.createTime),
                    style: const TextStyle(color: Colors.grey),
                  ),
                )));
        }
        notifyListeners();
      }
    });
  }
}
