import 'dart:convert';

import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/dialog/base_dialog.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/network/data/response_status.dart';
import 'package:csust_edu_system/network/http_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../ass/url_assets.dart';
import '../../data/date_info.dart';
import '../../network/data/http_response_code.dart';
import '../../network/data/http_response_data.dart';
import '../../ui/course/db/course_db_manager.dart';
import '../../ui/course/jsonbean/db_course_bean.dart';
import 'hint_dialog.dart';

/// 加载学期课表Dialog
///
/// @author zzp
/// @since 2023/10/1
/// @version v1.8.8
class CourseProgressDialog extends StatefulWidget with BaseDialog {
  /// 学期
  final String term;

  const CourseProgressDialog({Key? key, required this.term}) : super(key: key);

  @override
  State<CourseProgressDialog> createState() => _CourseProgressDialogState();
}

class _CourseProgressDialogState extends State<CourseProgressDialog> {
  /// 当前进度
  double _value = 0.0;

  /// 当前加载的周数
  int _nowWeekNum = 1;

  @override
  void initState() {
    super.initState();
    _doProgress();
  }

  _doProgress() async {
    int i;
    for (i = 1; i <= DateInfo.totalWeek; i++) {
      var res = await HttpHelper().post(
          UrlAssets.getWeekCourse,
          FormData.fromMap({
            KeyAssets.cookie: StuInfo.cookie,
            KeyAssets.xueqi: widget.term,
            KeyAssets.zc: i.toString()
          }),
          null);
      if (res.status == ResponseStatus.success) {
        var responseData = HttpResponseData.fromJson(res.data);
        if (responseData.code == HttpResponseCode.success) {
          String content = jsonEncode(responseData.data);
          var dbValue = await CourseDBManager.containsCourse(widget.term, i);
          if (dbValue == null) {
            await CourseDBManager.insertCourse(
                DBCourseBean(widget.term, i, content));
          } else {
            await CourseDBManager.updateCourse(content, dbValue.id);
          }
          setState(() {
            _value = i / DateInfo.totalWeek;
            _nowWeekNum = i;
          });
        } else {
          break;
        }
      } else {
        break;
      }
    }
    SmartDialog.dismiss();
    String helpText;
    if (i > DateInfo.totalWeek) {
      helpText = StringAssets.refreshSuccessNextTime;
    } else {
      helpText = '获取第$i周的课表失败了';
    }
    HintDialog(
      title: StringAssets.tips,
      subTitle: helpText,
    ).showDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(StringAssets.loading,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: LinearProgressIndicator(
                    value: _value,
                  ),
                ),
                RichText(
                  text: TextSpan(
                      text: _nowWeekNum.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                            text: '/${DateInfo.totalWeek}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ))
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
