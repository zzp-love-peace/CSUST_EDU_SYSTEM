import 'dart:io';

import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:dio/dio.dart';

import 'data/http_response.dart';
import 'data/response_status.dart';

/// 请求时间常量
const Duration constTimeOut = Duration(seconds: 6);

/// Http请求工具类
///
/// @author zzp
/// @since 2023/9/14
/// @version v1.8.8
class HttpHelper {
  /// 唯一单例对象
  static final HttpHelper _instance = HttpHelper._internal();

  /// url
  // static const _baseUrl = 'http://finalab.cn:8989';
  static const _baseUrl = 'http://cop.eigeen.com';

  /// dio对象
  Dio? _dio;

  /// 工厂构造函数
  factory HttpHelper() => _instance;

  /// 通用全局单例，第一次使用时初始化
  HttpHelper._internal() {
    _dio ??= Dio(BaseOptions(baseUrl: _baseUrl, connectTimeout: constTimeOut));
    _dio?.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (StuInfo.token.isNotEmpty) {
        options.headers[KeyAssets.token] = StuInfo.token;
      }
      return handler.next(options);
    }));
  }

  /// 静态获取单例方法
  static HttpHelper getInstance() => _instance;

  /// 通用的GET请求
  ///
  /// [path] url路径
  /// [params] 参数
  /// [responseType] 响应类型
  Future<HttpResponse> get(String path,
      {Map<String, dynamic>? params, ResponseType? responseType}) async {
    Response? response;
    HttpResponse res;
    try {
      response = await _dio?.get(path,
          queryParameters: params,
          options: Options(responseType: responseType));
      if (response?.statusCode == HttpStatus.ok) {
        res = HttpResponse(ResponseStatus.success, response!.data);
      } else {
        res = HttpResponse(ResponseStatus.fail, response?.statusMessage);
      }
    } on Exception catch (e) {
      res = HttpResponse(ResponseStatus.error, e);
    }
    return res;
  }

  /// 通用的POST请求
  ///
  /// [path] url路径
  /// [params] 参数
  /// [contentType] 内容类型
  Future<HttpResponse> post(String path, params, {String? contentType}) async {
    Response? response;
    HttpResponse res;
    try {
      response = await _dio?.post(path,
          data: params, options: Options(contentType: contentType));
      if (response?.statusCode == HttpStatus.ok) {
        res = HttpResponse(ResponseStatus.success, response!.data);
      } else {
        res = HttpResponse(ResponseStatus.fail, response?.statusMessage);
      }
    } on Exception catch (e) {
      res = HttpResponse(ResponseStatus.error, e);
    }
    return res;
  }
}
