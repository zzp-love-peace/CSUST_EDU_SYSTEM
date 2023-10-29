import 'package:csust_edu_system/ass/key_assets.dart';

/// 成绩详情Bean类
///
/// @author wk
/// @since 2023/10/29
/// @version v1.8.8
class GradeInfoBean {
  GradeInfoBean.fromJson(Map<String, dynamic> json)
      : normalGrade = json[KeyAssets.pscj] ?? '',
        normalGradePer = json[KeyAssets.pscjBL] ?? '',
        middleGrade = json[KeyAssets.qzcj] ?? '',
        middleGradePer = json[KeyAssets.qzcjBL] ?? '',
        finalGrade = json[KeyAssets.qmcj] ?? '',
        finalGradePer = json[KeyAssets.qmcjBL] ?? '';

  /// 平时成绩
  String normalGrade;

  /// 平时成绩比例
  String normalGradePer;

  /// 期中成绩
  String middleGrade;

  /// 期中成绩比例
  String middleGradePer;

  /// 期末成绩
  String finalGrade;

  /// 期末成绩比例
  String finalGradePer;
}
