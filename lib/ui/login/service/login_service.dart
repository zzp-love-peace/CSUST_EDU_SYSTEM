import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/utils/typedef_util.dart';
import 'package:dio/dio.dart';
import '../../../utils/my_util.dart';

/// 登录Service
///
/// @author zzp
/// @since 2023/9/13
class LoginService extends BaseService {

  /// 登录
  ///
  /// [username] 用户名
  /// [password] 密码
  /// [onDataSuccess] 获取数据成功回调
  /// [onDataFail] 获取数据失败回调
  /// [onPrepare] 请求前回调
  /// [onFinish] 请求结束回调
  void login(String username, String password, {required OnDataSuccess<KeyMap> onDataSuccess,
    OnDataFail? onDataFail, OnPrepare? onPrepare, OnFinish? onFinish}) {
    var params = FormData.fromMap({
      KeyAssets.stuNum: username,
      KeyAssets.password: password,
      KeyAssets.version: '$appName$version${getAppSuffix()}'});
    post(UrlAssets.login, params: params, onPrepare: onPrepare, onDataSuccess: onDataSuccess,
        onDataFail: onDataFail, onFinish: onFinish);
  }

  /// 获取日期数据
  ///
  /// [cookie] cookie字符串
  /// [onDataSuccess] 获取数据成功回调
  /// [onDataFail] 获取数据失败回调
  void getDateData(String cookie, {required OnDataSuccess<KeyMap> onDataSuccess,
    OnDataFail? onDataFail}) {
    post(UrlAssets.getBasicData, params: FormData.fromMap({KeyAssets.cookie: cookie}),
        onDataSuccess: onDataSuccess, onDataFail: onDataFail);
  }

  /// 获取学生详细信息
  ///
  /// [cookie] cookie字符串
  /// [onDataSuccess] 获取数据成功回调
  /// [onDataFail] 获取数据失败回调
  void getStuInfo(String cookie, {required OnDataSuccess<KeyMap> onDataSuccess,
    OnDataFail? onDataFail}) {
    post(UrlAssets.getStuInfo, params: FormData.fromMap({KeyAssets.cookie: cookie}),
        onDataSuccess: onDataSuccess, onDataFail: onDataFail);
  }
}