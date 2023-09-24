import 'package:flutter/material.dart';

/// 通用Toast
///
/// @author zzp
/// @since 2023/9/24
class CustomToast extends StatelessWidget {
  const CustomToast(this.msg, {Key? key}) : super(key: key);

  /// toast消息
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 50),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(msg, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
