import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:flutter/material.dart';

/// 写评论底部Sheet
///
/// @author zzp
/// @since 2023/10/26
/// @version v1.8.8
class WriteCommentBottomSheet extends StatelessWidget {
  const WriteCommentBottomSheet(
      {super.key,
      required this.contentController,
      required this.hint,
      required this.publishClickCallback});

  /// 内容输入控制器
  final TextEditingController contentController;

  /// 提示文字
  final String hint;

  /// 发布按钮点击回调
  final void Function(String content) publishClickCallback;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        padding: EdgeInsets.fromLTRB(
            10, 10, 10, MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              StringAssets.comment,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: TextField(
                controller: contentController,
                maxLength: 100,
                minLines: 5,
                maxLines: 5,
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: hint),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: const Text(
                      StringAssets.cancel,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: TextButton(
                    child: const Text(
                      StringAssets.publish,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                      if (contentController.text.isNotBlank()) {
                        publishClickCallback.call(contentController.text);
                      } else {
                        StringAssets.contentCannotEmpty.showToast();
                      }
                    },
                  ),
                  flex: 1,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
