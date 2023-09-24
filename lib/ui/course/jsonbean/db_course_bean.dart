import 'package:csust_edu_system/arch/basedata/base_json_bean.dart';
import 'package:csust_edu_system/ass/key_assets.dart';

/// 存入数据库的课程表Bean类
///
/// @author zzp
/// @since 2023/9/23
/// @version v1.8.8
class DBCourseBean extends BaseJsonBean {
  DBCourseBean(this.term, this.weekNum, this.content, {this.id = -1});

  DBCourseBean.fromMap(Map map)
      : id = map[KeyAssets.id],
        term = map[KeyAssets.term],
        weekNum = map[KeyAssets.weekNum],
        content = map[KeyAssets.content];

  /// id
  int id;

  /// 学期
  String term;

  /// 周数
  int weekNum;

  /// 内容
  String content;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        KeyAssets.id: id,
        KeyAssets.term: term,
        KeyAssets.weekNum: weekNum,
        KeyAssets.content: content,
      };
}
