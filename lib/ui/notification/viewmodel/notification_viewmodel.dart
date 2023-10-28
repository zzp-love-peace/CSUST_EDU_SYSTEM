import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ui/notification/jsonbean/notification_bean.dart';
import 'package:csust_edu_system/ui/notification/model/notification_model.dart';
import 'package:csust_edu_system/ui/notification/service/notification_service.dart';

/// 系统通知View model
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.19
class NotificationViewModel
    extends BaseViewModel<NotificationModel, NotificationService> {
  NotificationViewModel({required super.model});

  @override
  NotificationService? createService() => NotificationService();

  /// 初始化通知页面数据 -> 抓取信息，生成通知item并装入List
  void initNotificationPageData() {
    service?.getNotifications(
      onDataSuccess: (data, msg) {
        model.notificationList = data
            .map((json) => NotificationBean.fromJson(json))
            .toList()
            .reversed
            .toList();
        notifyListeners();
      },
    );
  }
}
