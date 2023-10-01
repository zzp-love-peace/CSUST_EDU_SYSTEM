import 'dart:convert';

import 'package:csust_edu_system/arch/basedata/base_json_bean.dart';
import 'package:csust_edu_system/ass/key_assets.dart';

/// 自定义课程表Bean类
///
/// @author zzp
/// @since 2023/9/21
/// @version v1.8.8
class CustomCourseBean extends BaseJsonBean {
  CustomCourseBean(this.name, this.place, this.teacher, this.time, this.index,
      this.weekNum, this.term);

  CustomCourseBean.fromJson(Map<String, dynamic> json)
      : name = json[KeyAssets.name],
        place = json[KeyAssets.place],
        teacher = json[KeyAssets.teacher],
        time = json[KeyAssets.time],
        index = json[KeyAssets.index],
        weekNum = json[KeyAssets.weekNum],
        term = json[KeyAssets.term];

  CustomCourseBean.fromJsonString(String jsonString)
      : this.fromJson(jsonDecode(jsonString));

  /// 课程名称
  String name;

  /// 上课地点
  String place;

  /// 授课老师
  String teacher;

  /// 上课时间（例如01-02节）
  String time;

  /// 课表索引（周日为1，周一为2，以此类推）
  int index;

  /// 周数
  int weekNum;

  /// 学期
  String term;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        KeyAssets.name: name,
        KeyAssets.place: place,
        KeyAssets.teacher: teacher,
        KeyAssets.time: time,
        KeyAssets.index: index,
        KeyAssets.weekNum: weekNum,
        KeyAssets.term: term,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomCourseBean &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          place == other.place &&
          teacher == other.teacher &&
          time == other.time &&
          index == other.index &&
          weekNum == other.weekNum &&
          term == other.term;

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + name.hashCode;
    result = 37 * result + place.hashCode;
    result = 37 * result + teacher.hashCode;
    result = 37 * result + time.hashCode;
    result = 37 * result + index.hashCode;
    result = 37 * result + weekNum.hashCode;
    result = 37 * result + term.hashCode;
    return result;
  }
}
