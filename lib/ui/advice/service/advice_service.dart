import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:dio/dio.dart';
import '../../../util/typedef_util.dart';

/// 反馈建议Service
///
/// @author bmc
/// @since 2023/9/23
/// @version v1.8.8
class AdviceService extends BaseService {


  /// 发送建议或反馈
  /// [advice] 建议内容
  /// [phone] 提供建议者的手机号
  /// [name] 提供建议者的用户名
  /// [onDataSuccess] 获取数据成功回调
  /// [onDataFail] 获取数据失败回调
  /// [onPrepare] 请求前回调
  /// [onFinish] 请求结束回调
  void postAdvice(String advice, String phone, String name,
      {required OnDataSuccess<KeyMap?> onDataSuccess,
      OnDataFail? onDataFail,
      OnPrepare? onPrepare,
      OnFinish? onFinish}) {
    var params = FormData.fromMap({
      KeyAssets.content: advice,
      KeyAssets.phone: phone,
      KeyAssets.name: name,
    });
    post(UrlAssets.postAdvice,
        params: params,
        onPrepare: onPrepare,
        onDataSuccess: onDataSuccess,
        onDataFail: onDataFail,
        onFinish: onFinish);
  }
}
