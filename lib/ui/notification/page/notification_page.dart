import 'package:csust_edu_system/ui/notification/model/notification_model.dart';
import 'package:csust_edu_system/ui/notification/viewmodel/notification_viewmodel.dart';
import 'package:csust_edu_system/utils/extension_uitl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/none_lottie.dart';
/// 系统通知Page
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.19
class NotificationPage extends StatelessWidget{
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>
          NotificationViewModel(model:NotificationModel()),
      )
    ],child: const NotificationHome());
  }
}

class NotificationHome extends StatefulWidget {
  const NotificationHome({Key? key}) : super(key: key);

  @override
  State<NotificationHome> createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {
  late NotificationViewModel _notificationViewModel;

  @override
  void initState() {
    super.initState();
    _notificationViewModel = context.getViewModel<NotificationViewModel>();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _notificationViewModel.initNotificationPageData());
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _notificationList = _notificationViewModel.model.notificationList;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "通知",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: _notificationList.isNotEmpty ? ListView(
          children: _notificationList,
        ) : const NoneLottie(hint: '暂无通知...')
    );
  }
}