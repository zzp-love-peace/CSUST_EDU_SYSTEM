import 'package:flutter/material.dart';

/// 反馈页Model类
///
/// @author bmc
/// @since 2023/9/22
/// @version v1.8.8

class AdviceModel {
  AdviceModel();

  /// 提交按钮是否可点击状态
  bool enable = false;

  /// 错误文本提示
  String? error;

  /// 手机号码输入控制器
  final phonenumController = TextEditingController();

  /// 建议或反馈输入控制器
  final adviceController = TextEditingController();
}