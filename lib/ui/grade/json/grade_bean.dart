import 'package:csust_edu_system/ass/key_assets.dart';

/// 成绩Bean类
///
/// @author wk
/// @since 2023/10/28
/// @version v1.8.8

class GradeBean {
  GradeBean.fromJson(Map<String, dynamic> json)
      : courseName = json[KeyAssets.courseName],
        point = json[KeyAssets.point],
        method = json[KeyAssets.method],
        property = json[KeyAssets.property],
        nature = json[KeyAssets.nature],
        xuefen = json[KeyAssets.xuefen],
        score = json[KeyAssets.score],
        pscjUrl = json[KeyAssets.pscjUrl];

  /// 学科名称
  String courseName;

  /// 绩点
  String point;

  /// 考试还是考查
  String method;

  /// 必修还是选修
  String property;

  /// 课程类别
  String nature;

  /// 分数
  String score;

  /// 学分
  String xuefen;

  /// pscjUrl
  String pscjUrl;
}
