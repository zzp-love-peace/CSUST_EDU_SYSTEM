import 'package:csust_edu_system/ass/key_assets.dart';

/// 成绩详情Bean类
///
/// @author wk
/// @since 2023/10/29
/// @version v1.8.8
class GradeInfoBean {
  GradeInfoBean.fromJson(Map<String, dynamic> json)
      : normalGrade = json[KeyAssets.normalGrade],
        normalGradePer = json[KeyAssets.normalGradePer],
        middleGrade = json[KeyAssets.middleGrade],
        middleGradePer = json[KeyAssets.middleGradePer],
        finalGrade = json[KeyAssets.finalGrade],
        finalGradePer = json[KeyAssets.finalGradePer];

  /// 平时成绩
  String? normalGrade;

  /// 平时成绩比例
  String? normalGradePer;

  /// 期中成绩
  String? middleGrade;

  /// 期中成绩比例
  String? middleGradePer;

  /// 期末成绩
  String? finalGrade;

  /// 期末成绩比例
  String? finalGradePer;
}
