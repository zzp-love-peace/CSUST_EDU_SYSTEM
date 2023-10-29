import 'package:csust_edu_system/util/db/db_data.dart';

import '../../../ass/string_assets.dart';
import '../../../util/db/db_manager.dart';
import '../json/db_grade_bean.dart';

/// 成绩表数据库管理器
///
/// @author wk
/// @since 2023/10/29
/// @version v1.8.8
class GradeDBManager {
  /// 获取某一学期成绩
  ///
  /// [term] 学期
  static Future<List<DBGradeBean>> getGradesOfTerm(String term) async {
    final res = await DBManager.getInstance()
        .rawQuery("select * from $gradeTableName where term=? ", [term]);
    return res.map((e) => DBGradeBean.fromMap(e)).toList();
  }

  /// 添加课程
  ///
  /// [dbGradeBean] 具体成绩
  static Future<DBGradeBean> insertGrade(DBGradeBean dbGradeBean) async {
    dbGradeBean.id = await DBManager.getInstance().rawInsert(
        'insert into $gradeTableName (term, courseName,content, infoContent) values (?, ?, ? ,?)',
        [
          dbGradeBean.term,
          dbGradeBean.courseName,
          dbGradeBean.content,
          dbGradeBean.infoContent
        ]);
    return dbGradeBean;
  }

  /// 更新成绩
  ///
  /// [content] 内容
  /// [id] id
  static Future<void> updateGrade(String content, int id) async {
    await DBManager.getInstance().rawUpdate(
        'update $gradeTableName set content=? where id=?', [content, id]);
  }

  /// 更新成绩详情
  ///
  /// [infoContent] 详情内容
  /// [id] id
  static Future<void> updateGradeInfo(String infoContent, int id) async {
    await DBManager.getInstance().rawUpdate(
        'update $gradeTableName set infoContent=? where id=?',
        [infoContent, id]);
  }

  /// 数据库是否存在某一成绩
  ///
  /// [term] 学期
  /// [courseName] 课程名
  static Future<DBGradeBean?> containsGrade(
      String term, String courseName) async {
    List gradeResult = await DBManager.getInstance().rawQuery(
        'select * from $gradeTableName where term=? and courseName=?',
        [term, courseName]);
    if (gradeResult.isEmpty) {
      return null;
    } else if (gradeResult.length == 1) {
      return DBGradeBean.fromMap(gradeResult[0]);
    } else {
      throw Exception(StringAssets.dbGradeDuplicated);
    }
  }
}
