import 'dart:async';
import 'dart:math';

import 'package:csust_edu_system/utils/course_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpManager {
  static final HttpManager _instance = HttpManager._internal();

  // static const _baseUrl = 'http://finalab.cn:8081';
  static const _baseUrl = 'http://47.97.205.5:8989';
  // static const _baseUrl = 'http://1.117.154.123:8081';
  // static const _baseUrl = 'http://101.34.59.239:8081';
  Dio? _dio;

  factory HttpManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal() {
    _dio ??= Dio(BaseOptions(baseUrl: _baseUrl, connectTimeout: 8000));
    // _dio ??= Dio(BaseOptions(baseUrl: _baseUrl, connectTimeout: 8000));
  }

  static HttpManager getInstance() => _instance;

  ///通用的GET请求
  Future _get(String path, {params, header}) async {
    Response? response;
    try {
      response = await _dio?.get(path,
          queryParameters: params,
          options: Options(headers: {"token": header}));
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return {};
    } on TimeoutException {
      return {};
    }
    if (response?.data is DioError) {
      return {};
    }
    // print(response?.data);
    return response?.data;
  }

  ///通用的POST请求
  Future _post(String path, params, {header}) async {
    Response? response;
    try {
      response = await _dio?.post(path,
          data: params, options: Options(headers: {"token": header}));
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return {};
    } on TimeoutException {
      return {};
    }
    if (response?.data is DioError) {
      return {};
    }
    // print(response?.data);
    return response?.data;
  }

  Future<Map> login(String username, String password) async => await _post(
      '/login', FormData.fromMap({'username': username, 'password': password}));

  Future<Map> getHeadImage(String cookie, String token) async =>
      await _post('/getHeadImg', FormData.fromMap({'cookie': cookie}),
          header: token);

  Future<Map> getAllSemester(String token) async =>
      await _get('/getAllSemester', header: token);

  Future<Map> queryScore(String token, String cookie, String term) async =>
      await _post(
          '/queryScore', FormData.fromMap({'cookie': cookie, 'xueqi': term}),
          header: token);

  Future<Map> queryExam(String token, String cookie, String term) async =>
      await _post(
          '/getKsap', FormData.fromMap({'cookie': cookie, 'xueqi': term}),
          header: token);

  Future<Map> queryScoreInfo(String token, String cookie, String url) async =>
      await _post(
          '/queryPscj', FormData.fromMap({'cookie': cookie, 'pscjUrl': url}),
          header: token);

  Future<Map> queryCourse(
          String token, String cookie, String term, String weekNum) async =>
      await _post('/getCourse',
          FormData.fromMap({'cookie': cookie, 'xueqi': term, 'zc': weekNum}),
          header: token);

  // 并行获取所有周的课程表
  Future<List> getAllCourse(
      String token, String cookie, String term, int totalWeek) async {
    List result = [];
    List<Future> futures = [];
    print(totalWeek);
    for (int i = 1; i <= totalWeek; i++) {
      futures.add(HttpManager().queryCourse(token, cookie, term, i.toString()));
    }
    var response = await Future.wait(futures);
    for (Map value in response) {
      if (value.isNotEmpty) {
        print(value);
        if (value['code'] == 200) {
          result.add(value['data']);
        }
        else {
          if (kDebugMode) {
            print('出异常了');
          }
          throw Exception('获取课表出错了');
        }
      } else {
        if (kDebugMode) {
          print('出异常了');
        }
        throw Exception('获取课表出错了');
      }
    }
    return result;
  }

  // 串行获取所有周的课程表
  // Future<List> getAllCourse(
  //     String token, String cookie, String term, int totalWeek) async {
  //   List result = [];
  //   // List<Future> futures = [];
  //   print(totalWeek);
  //   for (int i = 1; i <= totalWeek; i++) {
  //     var value =
  //         await HttpManager().queryCourse(token, cookie, term, i.toString());
  //     await Future.delayed(const Duration(milliseconds: 1500));
  //     if (value.isNotEmpty) {
  //       print(i);
  //       if (value['code'] == 200) {
  //         result.add(value['data']);
  //       } else {
  //         if (kDebugMode) {
  //           print('出异常了');
  //         }
  //         throw Exception('获取课表出错了');
  //       }
  //     } else {
  //       if (kDebugMode) {
  //         print('出异常了');
  //       }
  //       throw Exception('获取课表出错了');
  //     }
  //   }
  //   return result;
  // }
}
