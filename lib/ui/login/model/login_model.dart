import 'package:flutter/material.dart';

/// 登录页Bean类
///
/// @author zzp
/// @since 2023/9/12
class LoginModel {
  LoginModel({this.isRemember = false});

  /// 是否记住密码
  bool isRemember;
  /// 用户名输入控制器
  final usernameController = TextEditingController();
  /// 密码输入控制器
  final passwordController = TextEditingController();
}