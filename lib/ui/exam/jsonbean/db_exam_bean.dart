import 'package:csust_edu_system/arch/basedata/base_json_bean.dart';

import '../../../ass/key_assets.dart';

/// 存入数据库的考试Bean类
///
/// @author wk
/// @since 2023/11/5
/// @version V1.8.8
class DBExamBean extends BaseJsonBean {
  DBExamBean(this.term, this.courseName, this.content, {this.id = -1});

  DBExamBean.fromMap(Map map)
      : id = map[KeyAssets.id],
        term = map[KeyAssets.term],
        courseName = map[KeyAssets.courseName],
        content = map[KeyAssets.content];

  /// id
  int id;

  /// 学期
  String term;

  /// 考试课程名
  String courseName;

  /// 考试列表内容
  String content;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        KeyAssets.id: id,
        KeyAssets.term: term,
        KeyAssets.courseName: courseName,
        KeyAssets.content: content,
      };
}
