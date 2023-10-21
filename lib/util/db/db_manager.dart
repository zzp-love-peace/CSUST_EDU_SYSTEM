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
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int v) async {
      await db.execute(
          "create table $courseTableName(id integer primary key autoincrement, term text, weekNum integer, content text)");
    });
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
}
