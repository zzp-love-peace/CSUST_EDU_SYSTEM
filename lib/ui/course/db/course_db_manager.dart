import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../jsonbean/db_course_bean.dart';

/// 数据库名
const String _dbName = 'course.db';

/// 课程表表名
const String _tableName = 'course_week';

/// 课程表数据库管理器
class CourseDBManager {
  /// 数据库
  Database? myDatabase;

  /// 唯一单例
  static final CourseDBManager db = CourseDBManager._();

  /// 私有无参构造函数
  CourseDBManager._();

  /// 获取不为空的数据库
  Future<Database> getCheckDatabase() async {
    if (myDatabase != null) return myDatabase!;
    myDatabase = await initDB();
    return myDatabase!;
  }

  /// 初始化数据库
  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbName);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int v) async {
      await db.execute(
          "create table $_tableName(id integer primary key autoincrement, term text, weekNum integer, content text)");
    });
  }

  /// 获取某一学期课表
  ///
  /// [term] 学期
  Future<List<DBCourseBean>> getCoursesOfTerm(String term) async {
    final databaseDB = await getCheckDatabase();
    List res = await databaseDB.rawQuery(
        "select * from $_tableName where term=? order by weekNum", [term]);
    return res.map((e) => DBCourseBean.fromMap(e)).toList();
  }

  /// 添加课程
  ///
  /// [course] 具体课程
  Future<DBCourseBean> insertCourse(DBCourseBean course) async {
    final databaseDB = await getCheckDatabase();
    course.id = await databaseDB.rawInsert(
        'insert into $_tableName (term, weekNum, content) values (?, ? ,?)',
        [course.term, course.weekNum, course.content]);
    return course;
  }

  /// 更新课程
  ///
  /// [content] 内容
  /// [id] id
  Future<void> updateCourse(String content, int id) async {
    final databaseDB = await getCheckDatabase();
    int res = await databaseDB.rawUpdate(
        'update $_tableName set content=? where id=?', [content, id]);
  }

  /// 数据库是否存在某一课程
  ///
  /// [term] 学期
  /// [weekNum] 周数
  Future<DBCourseBean?> containsCourse(String term, int weekNum) async {
    final databaseDB = await getCheckDatabase();
    List courseResult = await databaseDB.rawQuery(
        'select * from $_tableName where term=? and weekNum=?',
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
