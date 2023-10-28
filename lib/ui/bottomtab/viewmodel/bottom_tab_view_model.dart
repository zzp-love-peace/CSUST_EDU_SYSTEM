import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/dialog/hint_dialog.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/bottomtab/model/bottom_tab_model.dart';
import 'package:csust_edu_system/ui/notification/service/notification_service.dart';
import 'package:csust_edu_system/util/date_util.dart';
import 'package:csust_edu_system/util/sp/sp_data.dart';

import '../../notification/jsonbean/notification_bean.dart';

/// 底部导航栏ViewModel类
///
/// @author zzp
/// @since 2023/9/19
/// @version v1.8.8
class BottomTabViewModel
    extends BaseViewModel<BottomTabModel, NotificationService> {
  BottomTabViewModel({required super.model});

  /// 上一次back触发时间
  DateTime? _lastBackTime;

  final SpData<List<String>> _spReadNotificationList = SpData<List<String>>(
      key: KeyAssets.readNotificationList, defaultValue: []);

  /// 改变页面index
  ///
  /// [index] 下标
  void setCurrentPageIndex(int index) {
    model.currentIndex = index;
    notifyListeners();
  }

  /// 展示未读通知
  ///
  /// [onFinish] 展示结束回调
  void showUnreadNotification({required Function onFinish}) {
    service?.getNotifications(
      onDataSuccess: (data, msg) {
        var notificationList = data
            .map((json) => NotificationBean.fromJson(json))
            .toList()
            .reversed
            .toList();
        var readNotifications = _spReadNotificationList.get();
        if (notificationList.isNotEmpty &&
            DateUtil.getDiffDays(notificationList[0].createTime) <= 3 &&
            !readNotifications.contains(notificationList[0].id.toString())) {
          HintDialog(
            title: StringAssets.notificationPageTitle,
            subTitle: notificationList[0].content,
            okCallback: () {
              onFinish.call();
            },
          ).showDialog(backDismiss: false);
          readNotifications.add(notificationList[0].id.toString());
          _spReadNotificationList.set(readNotifications);
        } else {
          onFinish.call();
        }
      },
    );
  }

  /// 是否要退出
  Future<bool> isExit() {
    if (_lastBackTime == null ||
        DateTime.now().difference(_lastBackTime!) >
            const Duration(milliseconds: 2500)) {
      _lastBackTime = DateTime.now();
      StringAssets.backAgain.showToast();
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  NotificationService? createService() => NotificationService();
}
