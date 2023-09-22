import 'package:csust_edu_system/network/http_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import '../data/stu_info.dart';
import '../widgets/custom_toast.dart';

class NoticeHome extends StatefulWidget {
  final String ggid;

  const NoticeHome(this.ggid, {Key? key}) : super(key: key);

  @override
  State<NoticeHome> createState() => _NoticeHomeState();
}

class _NoticeHomeState extends State<NoticeHome> {
  String _html = "";

  @override
  void initState() {
    super.initState();
    _getNoticeDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.white,
          title: const Text(
            "教务通知",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(
            children: [
            HtmlWidget(_html)],
    ));
  }

  _getNoticeDetail() async {
    var response = await HttpManager()
        .getNoticeDetail(StuInfo.cookie, StuInfo.token, widget.ggid);
    if (response.isNotEmpty) {
      if (response['code'] == 200) {
        if (response['data'].isNotEmpty) {
          if (response['data']['code'] == 200) {
            setState(() {
              _html = response['data']['data'];
            });
          }
        }
      } else {
        SmartDialog.compatible.showToast('', widget: CustomToast(response['msg']));
      }
    }
  }
}
