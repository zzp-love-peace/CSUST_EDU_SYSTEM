import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 电话卡添加客服微信
///
/// @author wk
/// @since 2023/9/26
/// @version 1.8.8
class TelephoneAddWeChatView extends StatelessWidget {
  const TelephoneAddWeChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
      child: GestureDetector(
        child: const Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Icon(Icons.group_add_outlined, color: Colors.cyan),
            SizedBox(
              width: 50,
            ),
            Expanded(
              child: Text(
                StringAssets.addWeChat,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Icon(
              Icons.navigate_next,
              color: Colors.black,
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        onTap: () {
          Clipboard.setData(const ClipboardData(text: '493018572'));
          StringAssets.copyWeChat.showToast();
        },
      ),
    );
  }
}
