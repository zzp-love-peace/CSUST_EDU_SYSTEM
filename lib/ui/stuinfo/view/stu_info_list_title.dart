import 'package:flutter/material.dart';

/// 个人资料listTile
///
/// @author wk
/// @since 2023/11/26
/// @version v1.8.8
class StuInfoListTile extends StatelessWidget {
  const StuInfoListTile(
      {super.key,
      required this.leading,
      required this.trailing,
      this.isTrailingButton = false,
      this.trailingButtonOnPressed,
      this.onPressed});

  /// leading-text
  final String leading;

  /// trailing-text
  final String trailing;

  /// 尾部是否为按钮
  final bool isTrailingButton;

  /// 尾部按钮点击事件
  final Function? trailingButtonOnPressed;

  /// 点击事件回调
  final VoidCallback? onPressed;

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
        child: !isTrailingButton
            ? Text(
                trailing,
                style: const TextStyle(color: Colors.black),
              )
            : OutlinedButton(
                onPressed: () {
                  trailingButtonOnPressed?.call();
                },
                child: Text(
                  trailing,
                  style: const TextStyle(color: Colors.black),
                ),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(width: 1),
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0)),
              ),
      ),
      onTap: () {
        onPressed?.call();
      },
    );
  }
}
