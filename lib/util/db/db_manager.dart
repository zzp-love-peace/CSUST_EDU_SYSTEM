import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db_data.dart';

/// 数据库管理器
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class DBManager {
  /// 数据库
  Database? _myDatabase;

  /// 唯一单例
  static final DBManager _db = DBManager._();

  /// 私有无参构造函数
  DBManager._();

  /// 静态获取单例方法
  static DBManager getInstance() => _db;

  /// 数据库课程表建表语句
  static const createCourseTableSql =
      'create table if not exists $courseTableName(id integer primary key autoincrement, term text, weekNum integer, content text)';

  ///数据库教务通知表建表语句
  static const createSchoolNoticeTableSql =
      '''create table if not exists $schoolNoticeTableName(id integer primary key autoincrement,
           ggid text, title text, time text, html text)''';

  /// 数据库成绩表建表语句
  static const createGradeTableSql =
      '''create table if not exists $gradeTableName(id integer primary key autoincrement,
          term text, courseName text, content text, infoContent text)''';

  /// 获取不为空的数据库
  Future<Database> _getCheckDatabase() async {
    if (_myDatabase != null) return _myDatabase!;
    _myDatabase = await _initDB();
    return _myDatabase!;
  }

  /// 初始化数据库
  Future<Database> _initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    return await openDatabase(
      path,
      version: 3,
      onOpen: (db) {},
      onCreate: (Database db, int v) async {
        await db.execute(createCourseTableSql);
        await db.execute(createSchoolNoticeTableSql);
        await db.execute(createGradeTableSql);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        await db.execute(createSchoolNoticeTableSql);
        await db.execute(createGradeTableSql);
      },
    );
  }

  /// 查询
  ///
  /// [sql] sql语句
  /// [arguments] 参数
  Future<List<Map<String, Object?>>> rawQuery(String sql,
      [List<Object?>? arguments]) async {
    final databaseDB = await _getCheckDatabase();
    return databaseDB.rawQuery(sql, arguments);
  }

  /// 插入
  ///
  /// [sql] sql语句
  /// [arguments] 参数
  Future<int> rawInsert(String sql, [List<Object?>? arguments]) async {
    final databaseDB = await _getCheckDatabase();
    return databaseDB.rawInsert(sql, arguments);
  }

  /// 更新
  ///
  /// [sql] sql语句
  /// [arguments] 参数
  Future<int> rawUpdate(String sql, [List<Object?>? arguments]) async {
    final databaseDB = await _getCheckDatabase();
    return databaseDB.rawUpdate(sql, arguments);
  }

  /// 删除
  ///
  /// [sql] sql语句
  /// [arguments] 参数
  Future<int> rawDelete(String sql, [List<Object?>? arguments]) async {
    final databaseDB = await _getCheckDatabase();
    return databaseDB.rawDelete(sql, arguments);
  }
}
