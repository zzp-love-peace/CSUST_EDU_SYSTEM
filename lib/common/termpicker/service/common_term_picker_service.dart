import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/util/typedef_util.dart';
import 'package:dio/dio.dart';

/// 通用学期选择器Service
///
/// @author zzp
/// @since 2023/9/20
/// @version v1.8.8
class CommonTermPickerService extends BaseService {
  /// 获取全部学期
  ///
  /// [cookie] cookie
  /// [onDataSuccess] 获取数据成功回调
  /// [onFinish] 请求结束回调
  void getAllTerm(
      {required String cookie,
      required OnDataSuccess<KeyList> onDataSuccess,
      OnFinish? onFinish}) {
    post(UrlAssets.getAllTerm,
        params: FormData.fromMap({KeyAssets.cookie: cookie}),
        onDataSuccess: onDataSuccess,
        onFinish: onFinish);
  }
}
