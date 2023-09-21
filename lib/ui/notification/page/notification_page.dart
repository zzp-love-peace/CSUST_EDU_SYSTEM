import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/notification/jsonbean/notification_bean.dart';
import 'package:csust_edu_system/ui/notification/model/notification_model.dart';
import 'package:csust_edu_system/ui/notification/viewmodel/notification_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ass/image_assets.dart';
import '../../../utils/date_util.dart';
import '../../../widgets/none_lottie.dart';

/// 系统通知Page
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.19
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => NotificationViewModel(model: NotificationModel()),
      )
    ], child: const NotificationHome());
  }
}

/// 系统通知页Home
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.19
class NotificationHome extends StatelessWidget {
  const NotificationHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            StringAssets.notificationPageTitle,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ConsumerView<NotificationViewModel>(
            onInit: (viewModel) {
              viewModel.initNotificationPageData();
             },
            builder: (context, viewModel, _) {
          List<NotificationBean> _notificationList = viewModel.model.notificationList;
          return _notificationList.isNotEmpty
              ? ListView.builder(
            itemCount: _notificationList.length,
            itemBuilder: (ctx, index) {
              return Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: ClipOval(
                      child: Image.asset(
                        ImageAssets.logo,
                        width: 36,
                        height: 36,
                      ),
                    ),
                    title: Text(_notificationList[index].content),
                    trailing: Text(
                      getForumDateString(_notificationList[index].createTime),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ));
            },) : const NoneLottie(hint: StringAssets.notificationPageNoContent);
        }));
  }
}
