import 'package:csust_edu_system/ass/image_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// 占位Lottie
///
/// @author zzp
/// @since 2023/9/24
/// @version v1.8.8
class NoneLottie extends StatelessWidget {
  const NoneLottie({Key? key, this.hint = StringAssets.messageEmpty})
      : super(key: key);

  /// 提示
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Stack(
          alignment: Alignment.bottomCenter,
              children: [
                Lottie.asset(ImageAssets.lottieLogo, width: 250, height: 250),
                Text(
                  hint,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            )
          ],
        ));
  }
}
