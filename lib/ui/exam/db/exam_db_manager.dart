import 'package:csust_edu_system/ui/exam/jsonbean/db_exam_bean.dart';

import '../../../ass/string_assets.dart';
import '../../../util/db/db_data.dart';
import '../../../util/db/db_manager.dart';

/// 考试表数据库管理器
///
/// @author wk
/// @since 2023/11/5
/// @version v1.8.8
class ExamDBManager {
  /// 获取某一学期考试
  ///
  /// [term] 学期
  static Future<List<DBExamBean>> getExamsOfTerm(String term) async {
    final res = await DBManager.getInstance()
        .rawQuery("select * from $examTableName where term=? ", [term]);
    return res.map((e) => DBExamBean.fromMap(e)).toList();
  }

  /// 添加考试
  ///
  /// [dbExamBean] 具体考试
  static Future<DBExamBean> insertExam(DBExamBean dbExamBean) async {
    dbExamBean.id = await DBManager.getInstance().rawInsert(
        'insert into $examTableName (term, courseName,content) values (?, ?, ? )',
        [
          dbExamBean.term,
          dbExamBean.courseName,
          dbExamBean.content,
        ]);
    return dbExamBean;
  }

  /// 更新考试
  ///
  /// [content] 内容
  /// [id] id
  static Future<void> updateExam(String content, int id) async {
    await DBManager.getInstance().rawUpdate(
        'update $examTableName set content=? where id=?', [content, id]);
  }

  /// 数据库是否存在某一考试
  ///
  /// [term] 学期
  /// [courseName] 课程名
  static Future<DBExamBean?> containsExam(
      String term, String courseName) async {
    List gradeResult = await DBManager.getInstance().rawQuery(
        'select * from $examTableName where term=? and courseName=?',
        [term, courseName]);
    if (gradeResult.isEmpty) {
      return null;
    } else if (gradeResult.length == 1) {
      return DBExamBean.fromMap(gradeResult[0]);
    } else {
      throw Exception(StringAssets.dbExamDuplicated);
    }
  }
}
