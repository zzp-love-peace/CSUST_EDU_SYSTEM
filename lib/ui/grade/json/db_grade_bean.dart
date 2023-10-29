import 'package:csust_edu_system/arch/basedata/base_json_bean.dart';
import 'package:csust_edu_system/ass/string_assets.dart';

import '../../../ass/key_assets.dart';

/// 存入数据库的成绩Bean类
///
/// @author wk
/// @since 2023/10/29
/// @version V1.8.8
class DBGradeBean extends BaseJsonBean {
  DBGradeBean(this.term, this.courseName, this.content,
      {this.id = -1, this.infoContent = StringAssets.emptyStr});

  DBGradeBean.fromMap(Map map)
      : id = map[KeyAssets.id],
        term = map[KeyAssets.term],
        courseName = map[KeyAssets.courseName],
        content = map[KeyAssets.content],
        infoContent = map[KeyAssets.infoContent];

  /// id
  int id;

  /// 学期
  String term;

  /// 课程名
  String courseName;

  /// 成绩列表内容
  String content;

  /// 成绩详情内容
  String infoContent;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        KeyAssets.id: id,
        KeyAssets.term: term,
        KeyAssets.courseName: courseName,
        KeyAssets.content: content,
        KeyAssets.infoContent: infoContent,
      };
}
