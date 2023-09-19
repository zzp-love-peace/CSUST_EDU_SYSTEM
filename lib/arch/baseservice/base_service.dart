import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/network/data/http_response_code.dart';
import 'package:csust_edu_system/network/data/http_response_data.dart';
import 'package:csust_edu_system/network/http_helper.dart';
import 'package:csust_edu_system/utils/extension_uitl.dart';
import 'package:csust_edu_system/utils/log.dart';
import '../../network/data/response_status.dart';
import '../../utils/typedef_util.dart';

/// 所有Service的基类
/// 
/// @author zzp
/// @since 2023/9/15
abstract class BaseService {

  /// get请求封装
  ///
  /// [path] 路径
  /// [params] 参数
  /// [onPrepare] 请求前回调
  /// [OnSuccess] 请求成功回调
  /// [OnFail] 请求失败回调
  /// [OnError] 请求异常回调
  /// [OnFinish] 请求结束回调
  void get<T>(String path, {Map<String, dynamic>? params, OnPrepare? onPrepare,
    required OnDataSuccess<T> onDataSuccess, OnDataFail? onDataFail, OnFail? onFail,
    OnError? onError, OnFinish? onFinish}) {
    var isSuccess = false;
    onPrepare?.call();
    HttpHelper().get(path, params).then((response) {
      switch (response.status) {
        case ResponseStatus.success:
          var responseData = HttpResponseData.fromJson(response.data);
          if (responseData.code == HttpResponseCode.success) {
            onDataSuccess.call(responseData.data, responseData.msg);
            isSuccess = true;
          } else {
            if (onDataFail == null) {
              _doDataFail(responseData.msg);
            } else {
              onDataFail.call(responseData.code, responseData.msg);
            }
          }
          break;
        case ResponseStatus.fail:
          if (onFail == null) {
            _doFail(response.data);
          } else {
            onFail(response.data);
          }
          break;
        case ResponseStatus.error:
          if (onError == null) {
            _doError(response.data);
          } else {
            onError(response.data);
          }
          break;
      }
      onFinish?.call(isSuccess);
    });
  }

  /// post请求封装
  ///
  /// [path] 路径
  /// [params] 参数
  /// [contentType] 内容格式
  /// [onPrepare] 请求前回调
  /// [OnSuccess] 请求成功回调
  /// [OnFail] 请求失败回调
  /// [OnError] 请求异常回调
  /// [OnFinish] 请求结束回调
  void post<T>(String path, {params, String? contentType, OnPrepare? onPrepare,
    required OnDataSuccess<T> onDataSuccess, OnDataFail? onDataFail, OnFail? onFail,
    OnError? onError, OnFinish? onFinish}) {
    var isSuccess = false;
    onPrepare?.call();
    HttpHelper().post(path, params, contentType).then((response) {
      switch (response.status) {
        case ResponseStatus.success:
          var responseData = HttpResponseData.fromJson(response.data);
          if (responseData.code == HttpResponseCode.success) {
            onDataSuccess.call(responseData.data, responseData.msg);
            isSuccess = true;
          } else {
            if (onDataFail == null) {
              _doDataFail(responseData.msg);
            } else {
              onDataFail.call(responseData.code, responseData.msg);
            }
          }
          break;
        case ResponseStatus.fail:
          if (onFail == null) {
            _doFail(response.data);
          } else {
            onFail(response.data);
          }
          break;
        case ResponseStatus.error:
          if (onError == null) {
            _doError(response.data);
          } else {
            onError(response.data);
          }
          break;
      }
      onFinish?.call(isSuccess);
    });
  }

  void _doDataFail(String msg) {
    '${StringAssets.getDataFail}:$msg'.showToast();
    Log.e(msg);
  }

  /// 请求失败的默认操作
  ///
  /// [msg] 错误信息
  void _doFail(String? msg) {
    StringAssets.requestFail.showToast();
    Log.e(msg);
  }

  /// 请求异常的默认操作
  ///
  /// [e] 异常
  void _doError(Exception e) {
    StringAssets.onError.showToast();
    Log.e(e.toString());
  }
}