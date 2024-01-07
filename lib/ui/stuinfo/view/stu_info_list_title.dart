import 'package:flutter/material.dart';

/// 个人资料listTile
///
/// @author wk
/// @since 2023/11/26
/// @version v1.8.8
class StuInfoListTile extends StatelessWidget {
  const StuInfoListTile(
      {super.key, required this.leading, required this.trailing, this.onPress});

  /// leading-text
  final String leading;

  /// trailing-text
  final String trailing;

  /// 点击事件回调
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          leading,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(
          trailing,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      onTap: () {
        onPress?.call();
      },
    );
  }
}
