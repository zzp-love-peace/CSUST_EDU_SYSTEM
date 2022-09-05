import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../data/course_model.dart';

class DBManager {
  Database? myDatabase;
  String tableName = 'course_week';

  static final DBManager db = DBManager._();

  DBManager._();

  Future<Database?> getCheckDatabase() async {
    if (myDatabase != null) return myDatabase;
    myDatabase = await initDB();
    return myDatabase;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'course.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int v) async {
      await db.execute(
          "create table $tableName(id integer primary key autoincrement, term text, weekNum integer, content text)");
    });
  }

  Future<List> getCoursesOfTerm(String term) async {
    final Database? databaseDB = await getCheckDatabase();
    List res = await databaseDB!.rawQuery(
        "select * from $tableName where term=? order by weekNum", [term]);
    return res.map((e) => CourseModel.fromMap(e)).toList();
  }

  // Future<CourseModel> insertCourse(CourseModel course) async {
  //   final Database? databaseDB = await getCheckDatabase();
  //   course.id = await databaseDB!.insert(tableName, course.toMap());
  //   return course;
  // }

  Future<CourseModel> insertCourse(CourseModel course) async {
    final Database? databaseDB = await getCheckDatabase();
    course.id = await databaseDB!.rawInsert(
        'insert into $tableName (term, weekNum, content) values (?, ? ,?)',
        [course.term, course.weekNum, course.content]);
    return course;
  }

  updateCourse(String content, int id) async {
    final Database? databaseDB = await getCheckDatabase();
    int res = await databaseDB!.rawUpdate(
        'update $tableName set content=? where id=?',
        [content, id]);
  }

  Future<CourseModel?> containsCourse(String term, int weekNum) async {
    final Database? databaseDB = await getCheckDatabase();
    List courseResult = await databaseDB!.rawQuery(
        'select * from $tableName where term=? and weekNum=?', [term, weekNum]);
    if (courseResult.isEmpty) {
      return null;
    } else if (courseResult.length == 1) {
      ;
      return CourseModel.fromMap(courseResult[0]);
    } else {
      throw Exception('数据库课程数据重复');
    }
  }
}
