import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../arch/baseviewmodel/base_view_model.dart';
import '../../../ass/string_assets.dart';
import '../../../common/dialog/hint_dialog.dart';
import '../../../data/stu_info.dart';
import '../model/advice_model.dart';
import '../service/advice_service.dart';

///意见反馈ViewModel
///
/// @author bmc
/// @since 2023/9/30
/// @version v1.8.8
class AdviceViewModel extends BaseViewModel<AdviceModel, AdviceService> {
  AdviceViewModel({required super.model});

  @override
  AdviceService? createService() => AdviceService();

  /// 发送建议到服务器
  void addAdvice() {
    if (checkPhoneNum()) {
      service?.postAdvice(
          model.adviceController.text,
          model.phoneNumController.text,
          StuInfo.name, onDataSuccess: (data, msg) {
        StringAssets.submitSuccess.showToast();
        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.of(context).pop();
        });
      }, onDataFail: (code, msg) {
        HintDialog(title: StringAssets.tips, subTitle: msg).showDialog();
      }, onFinish: (_) {
        SmartDialog.dismiss();
      });
      notifyListeners();
    }
  }

  /// 改变submitButton的enable属性
  /// @author bmc
  /// @since 2023/9/30
  /// @version v1.8.8
  void changeEnable() {
    if (model.phoneNumController.text.isNotEmpty &&
        model.adviceController.text.isNotEmpty) {
      model.enable = true;
    } else {
      model.enable = false;
    }
    notifyListeners();
  }

  /// 检查手机号格式是否正确
  bool checkPhoneNum() {
    String phoneNum = model.phoneNumController.text;
    if (model.enable) {
      RegExp exp =
          RegExp(r'^((13\d)|(14\d)|(15\d)|(16\d)|(17\d)|(18\d)|(19\d))\d{8}$');
      bool matched = exp.hasMatch(phoneNum);
      if (!matched) {
        model.error = StringAssets.phoneNumFormatWrong;
        notifyListeners();
        return false;
      }
    }
    return true;
  }
}
