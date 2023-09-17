import 'package:csust_edu_system/ass/key_assets.dart';

/// 登录Bean类
///
/// @author zzp
/// @since 2023/9/16
class LoginBean {
  LoginBean.fromJson(Map<String, dynamic> json):
        token = json[KeyAssets.token], cookie = json[KeyAssets.cookie];

  /// token
  String token;
  /// cookie
  String cookie;
}