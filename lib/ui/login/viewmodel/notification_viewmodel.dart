import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/jsonbean/notification_bean.dart';
import 'package:csust_edu_system/ui/login/model/notification_model.dart';
import 'package:csust_edu_system/ui/login/service/notification_service.dart';
import 'package:flutter/material.dart';

import '../../../utils/date_util.dart';
/// 系统通知View model
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.19
class NotificationViewModel extends BaseViewModel<NotificationModel> {
  NotificationViewModel({required super.model});

  final NotificationService _service = NotificationService();

  void initNotificationPageData() {
    _service.getNotifications(onDataSuccess: (data, msg) {
      List notifications = data;
      if (notifications.isNotEmpty) {
        if (msg == '200') {
          for (var notification in notifications) {
            var notificationJson = NotificationBean.fromJson(notification);
            model.notificationList.add(Container(
                color: Colors.white,
                child: ListTile(
                  leading: ClipOval(
                    child: Image.asset(
                      'assets/images/logo.png',
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
        }
      notifyListeners();
      }
    });
  }
}
