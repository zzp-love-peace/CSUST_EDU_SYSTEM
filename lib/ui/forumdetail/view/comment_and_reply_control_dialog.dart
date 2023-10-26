import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/dialog/base_dialog.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../common/dialog/hint_dialog.dart';
import '../../../common/dialog/select_dialog.dart';

/// 评论和回复控制Dialog
///
/// @author zzp
/// @since 2023/10/26
/// @version v1.8.8
class CommentAndReplyControlDialog extends StatelessWidget with BaseDialog {
  const CommentAndReplyControlDialog(
      {super.key,
      required this.isMine,
      required this.content,
      required this.replyClickCallback,
      required this.deleteClickCallback});

  /// 是否是自己的评论或回复
  final bool isMine;

  /// 内容
  final String content;

  /// 回复点击回调
  final void Function() replyClickCallback;

  /// 删除点击回调
  final void Function() deleteClickCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {
                      SmartDialog.dismiss();
                      Clipboard.setData(ClipboardData(text: content));
                      StringAssets.copySuccess.showToast();
                    },
                    child: const Text(
                      StringAssets.copy,
                      style: TextStyle(fontSize: 16),
                    )),
              ),
              if (isMine)
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      SmartDialog.dismiss();
                      SelectDialog(
                        title: StringAssets.tips,
                        subTitle: StringAssets.deleteCommentTips,
                        okCallback: () {
                          deleteClickCallback.call();
                        },
                      ).showDialog();
                    },
                    child: const Text(
                      StringAssets.delete,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      SmartDialog.dismiss();
                      SelectDialog(
                        title: StringAssets.tips,
                        subTitle: StringAssets.reportCommentTips,
                        okCallback: () {
                          SmartDialog.showLoading(msg: StringAssets.uploading);
                          Future.delayed(
                            const Duration(milliseconds: 1200),
                            () {
                              SmartDialog.dismiss();
                              const HintDialog(
                                      title: StringAssets.tips,
                                      subTitle: StringAssets.reportSuccessTips)
                                  .showDialog();
                            },
                          );
                        },
                      ).showDialog();
                    },
                    child: const Text(
                      StringAssets.report,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    SmartDialog.dismiss();
                    replyClickCallback.call();
                  },
                  child: const Text(
                    StringAssets.reply,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
