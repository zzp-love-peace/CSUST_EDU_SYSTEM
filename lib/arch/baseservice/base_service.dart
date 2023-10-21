import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/network/data/http_response.dart';
import 'package:csust_edu_system/network/data/http_response_code.dart';
import 'package:csust_edu_system/network/data/http_response_data.dart';
import 'package:csust_edu_system/network/http_helper.dart';
import 'package:csust_edu_system/util/log.dart';

import '../../network/data/response_status.dart';
import '../../util/typedef_util.dart';

/// 所有Service的基类
///
/// @author zzp
/// @since 2023/9/15
/// @version v1.8.8
abstract class BaseService {
  /// get请求封装
  ///
  /// [path] 路径
  /// [params] 参数
  /// [onPrepare] 请求前回调
  /// [onDataSuccess] 获取数据成功回调
  /// [OnDataFail] 获取数据失败回调
  /// [OnFail] 请求失败回调
  /// [OnError] 请求异常回调
  /// [OnFinish] 请求结束回调
  void get<T>(String path,
      {Map<String, dynamic>? params,
      OnPrepare? onPrepare,
      required OnDataSuccess<T> onDataSuccess,
      OnDataFail? onDataFail,
      OnFail? onFail,
      OnError? onError,
      OnFinish? onFinish}) {
    onPrepare?.call();
    HttpHelper().get(path, params: params).then((response) {
      handleHttpResponse(
          url: path,
          response: response,
          onDataSuccess: onDataSuccess,
          onDataFail: onDataFail,
          onFail: onFail,
          onError: onError,
          onFinish: onFinish);
    });
  }

  /// post请求封装
  ///
  /// [path] 路径
  /// [params] 参数
  /// [contentType] 内容格式
  /// [onPrepare] 请求前回调
  /// [onDataSuccess] 获取数据成功回调
  /// [OnDataFail] 获取数据失败回调
  /// [OnFail] 请求失败回调
  /// [OnError] 请求异常回调
  /// [OnFinish] 请求结束回调
  void post<T>(String path,
      {params,
      String? contentType,
      OnPrepare? onPrepare,
      required OnDataSuccess<T> onDataSuccess,
      OnDataFail? onDataFail,
      OnFail? onFail,
      OnError? onError,
      OnFinish? onFinish}) {
    onPrepare?.call();
    HttpHelper().post(path, params, contentType).then((response) {
      handleHttpResponse(
          url: path,
          response: response,
          onDataSuccess: onDataSuccess,
          onDataFail: onDataFail,
          onFail: onFail,
          onError: onError,
          onFinish: onFinish);
    });
  }

  /// 处理http请求结果
  ///
  /// [url] 接口路径
  /// [response] http请求结果
  /// [onDataSuccess] 获取数据成功回调
  /// [OnDataFail] 获取数据失败回调
  /// [OnFail] 请求失败回调
  /// [OnError] 请求异常回调
  /// [OnFinish] 请求结束回调
  void handleHttpResponse<T>(
      {required String url,
      required HttpResponse response,
      required OnDataSuccess<T> onDataSuccess,
      OnDataFail? onDataFail,
      OnFail? onFail,
      OnError? onError,
      OnFinish? onFinish}) {
    var isSuccess = false;
    switch (response.status) {
      case ResponseStatus.success:
        var responseData = HttpResponseData.fromJson(response.data);
        if (responseData.code == HttpResponseCode.success) {
          onDataSuccess.call(responseData.data, responseData.msg);
          isSuccess = true;
        } else {
          if (onDataFail == null) {
            _doDataFail(url, responseData);
          } else {
            onDataFail.call(responseData.code, responseData.msg);
          }
        }
        break;
      case ResponseStatus.fail:
        if (onFail == null) {
          _doFail(url, response.data);
        } else {
          onFail(response.data);
        }
        break;
      case ResponseStatus.error:
        if (onError == null) {
          _doError(url, response.data);
        } else {
          onError(response.data);
        }
        break;
    }
    onFinish?.call(isSuccess);
  }

  /// 获取数据失败的默认操作
  ///
  /// [url] 接口路径
  /// [errorData] 错误数据
  void _doDataFail(String url, HttpResponseData errorData) {
    '${StringAssets.getDataFail}:${errorData.msg}'.showToast();
    Log.e('url=>$url, onDataFail=>$errorData');
  }

  /// 请求失败的默认操作
  ///
  /// [url] 接口路径
  /// [msg] 错误信息
  void _doFail(String url, String? msg) {
    StringAssets.requestFail.showToast();
    Log.e('url=>$url, onFail=>$msg');
  }

  /// 请求异常的默认操作
  ///
  /// [url] 接口路径
  /// [e] 异常
  void _doError(String url, Exception e) {
    StringAssets.onError.showToast();
    Log.e('url=>$url, onError=>$e');
  }
}
