import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/telephonecard/model/telephone_picker_model.dart';
import 'package:csust_edu_system/ui/telephonecard/service/telephone_picker_service.dart';
import 'package:csust_edu_system/ui/telephonecard/viewmodel/telephone_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../ass/key_assets.dart';
import '../../../ass/string_assets.dart';
import '../jsonbean/card_number_bean.dart';

/// 电话卡选择器View Model
///
/// @author wk
/// @since 2023/9/25
/// @version v1.8.8
class TelephonePickerViewModel
    extends BaseViewModel<TelephonePickerModel, TelephonePickerService> {
  TelephonePickerViewModel({required super.model});

  @override
  TelephonePickerService? createService() => TelephonePickerService();

  /// 设置当前选择器值
  ///
  /// [text] 当前选择器值
  void setText(String text) {
    model.text = text;
    notifyListeners();
  }

  /// 根据套餐，校区获取卡号列表
  ///
  /// [title] picker标题
  /// [text] 选择的值
  /// [school] 校区
  /// [package] 套餐
  void getNumberList(String title, String text, String school, String package) {
    if (school.startsWith(StringAssets.clickSelect) ||
        package.startsWith(StringAssets.clickSelect)) {
      StringAssets.schoolAreaOrPackageUnselect.showToast();
    } else {
      if (package == StringAssets.package59) {
        package = StringAssets.fiftyNine;
      }
      if (package == StringAssets.package28) {
        package = StringAssets.twentyEight;
      }
      service?.getCardByKind(
        school,
        package,
        onDataSuccess: (data, msg) {
          List records = data[KeyAssets.records];
          model.pickerData =
              records.map((json) => CardNumberBean.fromJson(json)).toList();
          model.picker.showPicker(context,
              title: title,
              pickerData: model.pickerData,
              initIndex: model.pickerData.indexOf(text),
              onConfirm: (value, index) {
            setText(value.toString());
            var telephoneModel = context.read<TelephoneViewModel>().model;
            CardNumberBean bean = value;
            telephoneModel.number = bean.mobile;
            telephoneModel.cardId = bean.id;
          });
        },
      );
    }
  }
}
