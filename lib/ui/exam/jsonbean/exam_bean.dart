import 'package:csust_edu_system/ass/key_assets.dart';

/// 考试Bean类
///
/// @author wk
/// @since 2023/11/4
/// @version v1.8.8

class ExamBean {
  ExamBean.fromJson(Map<String, dynamic> json)
      : examName = json[KeyAssets.courseName],
        examAddress = json[KeyAssets.address],
        date = json[KeyAssets.startTime].toString().split(' ')[0],
        examDate =
            json[KeyAssets.startTime].toString().split(' ')[0].split('-'),
        startTime = json[KeyAssets.startTime].toString().split(' ')[1],
        endTime = json[KeyAssets.endTime].toString().split(' ')[1];

  /// 考试名称
  String examName;

  /// 考试地址
  String examAddress;

  /// 考试开始时间
  String startTime;

  /// 考试结束时间
  String endTime;

  /// 考试日期
  List<String> examDate;

  /// 考试日期(用于比较当前日期)
  String date;
}
