import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


class HttpManager {
  static final HttpManager _instance = HttpManager._internal();

  // static const _baseUrl = 'http://finalab.cn:8989';
  static const _baseUrl = 'http://cop.eigeen.com';

  // static const _baseUrl = 'http://47.97.205.5:8989';

  Dio? _dio;

  factory HttpManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal() {
    _dio ??= Dio(BaseOptions(
        baseUrl: _baseUrl, connectTimeout: const Duration(milliseconds: 8000)));
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

  Future<Map> setStuInfo(String token, String username, bool sex) async =>
      await _post('/setStuInfo',
          params: FormData.fromMap({'username': username, 'sex': sex}),
          headers: {"token": token});

  Future<Map> setHeadImg(String token, String imgPath) async =>
      await _post(
          '/setHeadImg',
          params: FormData.fromMap(
              {'img': await MultipartFile.fromFile(imgPath)}),
          headers: {"token": token});

  Future<Map> restoreHeadImg(String cookie, String token) async =>
      await _post('/restoreHeadImg',
          params: FormData.fromMap({'cookie': cookie}),
          headers: {"token": token});

  Future<Map> refreshStuInfo(String cookie, String token) async =>
      await _post('/refreshStuInfo',
          params: FormData.fromMap({'cookie': cookie}),
          headers: {"token": token});
}
