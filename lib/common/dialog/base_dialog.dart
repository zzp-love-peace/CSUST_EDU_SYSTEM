import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 基本Dialog
///
/// @author zzp
/// @since 2023/10/1
/// @version v1.8.8
mixin BaseDialog on Widget {
  /// 展示Dialog
  void showDialog({bool? backDismiss}) {
    SmartDialog.show(
        builder: (_) => this,
        clickMaskDismiss: false,
        backDismiss: backDismiss);
  }
}
