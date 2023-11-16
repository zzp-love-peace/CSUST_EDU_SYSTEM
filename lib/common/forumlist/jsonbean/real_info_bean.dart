import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';

/// 实名信息Bean类
///
/// @author zzp
/// @since 2023/10/27
/// @version v1.8.8
class RealInfoBean {
  RealInfoBean.fromJson(Map<String, dynamic> json)
      : stuId = json[KeyAssets.stuId]??StringAssets.emptyStr,
        name = json[KeyAssets.name],
        college = json[KeyAssets.college]??StringAssets.emptyStr,
        major = json[KeyAssets.major]??StringAssets.emptyStr,
        className = json[KeyAssets.className]??StringAssets.emptyStr;

  /// 学号
  String stuId;

  /// 姓名
  String name;

  /// 学院
  String college;

  /// 专业
  String major;

  /// 班级
  String className;
}
