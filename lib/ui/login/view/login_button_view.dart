import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:flutter/material.dart';

/// 登录按钮
///
/// @author zzp
/// @since 2023/9/12
/// @version v1.8.8
class LoginButtonView extends StatelessWidget {
  const LoginButtonView({super.key, required this.onPress});

  /// 点击事件回调
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const SizedBox(
        child: Center(
          child: Text(
            StringAssets.login,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        width: double.infinity,
      ),
      style: ButtonStyle(
        padding:
        MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 10, 0, 10)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      ),
      onPressed: () {
        onPress.call();
      },
    );
  }
}
