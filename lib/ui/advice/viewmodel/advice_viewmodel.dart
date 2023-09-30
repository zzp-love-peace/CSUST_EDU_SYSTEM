import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../../../arch/baseviewmodel/base_view_model.dart';
import '../../../ass/string_assets.dart';
import '../../../common/dialog/hint_dialog.dart';
import '../../../data/stu_info.dart';
import '../../../util/log.dart';
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
  ///
  /// [advice] 要发送的建议
  /// [phone] 发送者手机号
  void addAdvice(String advice, String phone) {
    Log.d('service=>$service');
    service?.postAdvice(advice, phone, StuInfo.name,
        onDataSuccess: (data, msg) {
      Log.e('code=>$data, msg=>$msg, model=>$model');
      StringAssets.submitSuccess.showToast();
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.of(context).pop();
      });
    }, onDataFail: (code, msg) {
      SmartDialog.show(
          builder: (_) => HintDialog(title: StringAssets.tips, subTitle: msg));
      Log.e('code=>$code, msg=>$msg');
    }, onFinish: (_) {
      SmartDialog.dismiss();
    });
    notifyListeners();
  }

  /// 改变submitButton的enable属性
  /// @author bmc
  /// @since 2023/9/30
  /// @version v1.8.8
  void chageEnable() {
    if (model.phonenumController.text.isNotEmpty &&
        model.adviceController.text.isNotEmpty) {
      model.enable = true;
    } else {
      model.enable = false;
    }
    notifyListeners();
  }

  /// 检查手机号格式是否正确
  /// [phoneNum] 被检查的手机号
  String? checkPhoneNum(String phoneNum) {
    if (model.enable) {
      RegExp exp =
      RegExp(r'^((13\d)|(14\d)|(15\d)|(16\d)|(17\d)|(18\d)|(19\d))\d{8}$');
      bool matched = exp.hasMatch(phoneNum);
      if (matched) {
        return null;
      } else {
        return StringAssets.phoneNumFormatWrong;
      }
    }
    return null;
  }
}
