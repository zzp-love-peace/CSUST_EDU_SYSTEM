import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/util/db/db_manager.dart';

import '../../../util/db/db_data.dart';
import '../jsonbean/db_course_bean.dart';

/// 课程表数据库管理器
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class CourseDBManager {
  /// 获取某一学期课表
  ///
  /// [term] 学期
  static Future<List<DBCourseBean>> getCoursesOfTerm(String term) async {
    final res = await DBManager.getInstance().rawQuery(
        "select * from $courseTableName where term=? order by weekNum", [term]);
    return res.map((e) => DBCourseBean.fromMap(e)).toList();
  }

  /// 添加课程
  ///
  /// [course] 具体课程
  static Future<DBCourseBean> insertCourse(DBCourseBean course) async {
    await DBManager.getInstance().rawDelete(
        'delete from $courseTableName where term=? and weekNum=?',
        [course.term, course.weekNum]);
    course.id = await DBManager.getInstance().rawInsert(
        'insert into $courseTableName (term, weekNum, content) values (?, ? ,?)',
        [course.term, course.weekNum, course.content]);
    return course;
  }

  /// 更新课程
  ///
  /// [content] 内容
  /// [id] id
  static Future<void> updateCourse(String content, int id) async {
    await DBManager.getInstance().rawUpdate(
        'update $courseTableName set content=? where id=?', [content, id]);
  }

  /// 数据库是否存在某一课程
  ///
  /// [term] 学期
  /// [weekNum] 周数
  static Future<DBCourseBean?> containsCourse(String term, int weekNum) async {
    List courseResult = await DBManager.getInstance().rawQuery(
        'select * from $courseTableName where term=? and weekNum=?',
        [term, weekNum]);
    if (courseResult.isEmpty) {
      return null;
    } else if (courseResult.length == 1) {
      return DBCourseBean.fromMap(courseResult[0]);
    } else {
      throw Exception(StringAssets.dbCourseDuplicated);
    }
  }
}
