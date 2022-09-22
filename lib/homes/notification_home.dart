import 'package:csust_edu_system/network/http_manager.dart';
import 'package:csust_edu_system/widgets/none_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../data/stu_info.dart';
import '../utils/date_util.dart';
import '../widgets/custom_toast.dart';

class NotificationHome extends StatefulWidget {
  const NotificationHome({Key? key}) : super(key: key);

  @override
  State<NotificationHome> createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {

  List<Widget> _noticeList = [];

  @override
  void initState() {
    super.initState();
    _getNotifications();
  }

  @override
  Widget build(BuildContext context) {
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
      body: _noticeList.isNotEmpty ? ListView(
        children: _noticeList,
      ) : const NoneLottie(hint: '暂无通知...')
    );
  }


  _getNotifications(){
    HttpManager().getNotifications(StuInfo.token) .then((value) {
      if (value.isNotEmpty) {
        // print(value);
        if (value['code'] == 200) {
            List<Widget> list = [];
            List notices = value['data'];
            for (var notice in notices) {
              list.add(
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      leading: ClipOval(child: Image.asset('assets/images/logo.png',width: 36, height: 36,),),
                      title: Text(notice['content']),
                      trailing: Text(getForumDateString(notice['createTime']), style: const TextStyle(color: Colors.grey),),
                    ),
                  )
              );
            }
            setState(() {
              _noticeList = list;
            });
        } else {
          SmartDialog.compatible
              .showToast('', widget: CustomToast(value['msg']));
        }
      } else {
        SmartDialog.compatible
            .showToast('', widget: const CustomToast('出现异常了'));
      }
    }, onError: (_) {
      SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了'));
    });
  }
}

