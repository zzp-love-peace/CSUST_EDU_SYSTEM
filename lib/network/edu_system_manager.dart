import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class EduSystemManager {
  static final EduSystemManager _instance = EduSystemManager._internal();

  static const _baseUrl = 'http://xk.csust.edu.cn';

  Dio? _dio;

  factory EduSystemManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  EduSystemManager._internal() {
    _dio ??= Dio(BaseOptions(baseUrl: _baseUrl, connectTimeout: 8000));
    // _dio ??= Dio(BaseOptions(baseUrl: _baseUrl, connectTimeout: 8000));
  }

  static EduSystemManager getInstance() => _instance;

  Future _get(String path, {params, headers}) async {
    Response? response;
    try {
      response = await _dio?.get(path,
          queryParameters: params,
          options: Options(headers: headers));
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

  Future _post(String path, {params, headers, contentType}) async {
    Response? response;
    try {
      response = await _dio?.post(path,
          data: params,
          options: Options(headers: headers, contentType: contentType));
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
    return response?.data;
  }

  Future getCourseHtml(String cookie, String term, int week) async =>
      await _post('/jsxsd/xskb/xskb_list.do',
          params: FormData.fromMap({'xnxq01id': term, 'zc': week.toString()}),
          headers: {'Cookie': cookie});

  Future getExamHtml(String cookie, String term) async =>
      await _post('/jsxsd/xsks/xsksap_list',
          params: FormData.fromMap({'xnxqid': term, 'xqlbmc': '', 'xqlb': ''}),
          headers: {
            'cookie': cookie,
            'Referer': 'http://xk.csust.edu.cn/jsxsd/xsks/xsksap_query'
          });

  Future getScoreHtml(String cookie, String term) async =>
      await _post('/jsxsd/kscj/cjcx_list',
          params: FormData.fromMap({
            'kksj': term,
            'kcxz': '',
            'kmmc': '',
            'xsfs': 'all',
            'fxkc': '2'
          }),
          headers: {
            'Cookie': cookie,
            'Referer': 'http://xk.csust.edu.cn/jsxsd/kscj/cjcx_query'
          });

  Future getScoreInfoHtml(String cookie, String scoreUrl) async =>
      await _get(scoreUrl, headers: {
        'Cookie': cookie,
      });


}
