import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/telephonecard/model/telephone_picker_model.dart';
import 'package:csust_edu_system/ui/telephonecard/service/telephone_picker_service.dart';
import 'package:csust_edu_system/ui/telephonecard/viewmodel/telephone_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';
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
  /// [school] 校区
  /// [package] 套餐
  void getNumberList(String title, String school, String package) {
    if (school.startsWith(StringAssets.clickSelect) ||
        package.startsWith(StringAssets.clickSelect)) {
      '校区或套餐未选择'.showToast();
    } else {
      if (package == StringAssets.package59) {
        package = '59';
      }
      if (package == StringAssets.package28) {
        package = '28';
      }
      service?.getCardByKind(
        school,
        package,
        onDataSuccess: (data, msg) {
          List records = data[KeyAssets.records];
          model.pickerData =
              records.map((json) => CardNumberBean.fromJson(json)).toList();
          notifyListeners();
          Picker(
            title: Text(
              title,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            confirmText: StringAssets.ok,
            cancelText: StringAssets.cancel,
            adapter: PickerDataAdapter<dynamic>(pickerData: model.pickerData),
            changeToFirst: true,
            hideHeader: false,
            onConfirm: (Picker picker, List value) {
              setText(picker.adapter.text
                  .substring(1, picker.adapter.text.length - 1));
              var telephoneModel = context.read<TelephoneViewModel>().model;
              CardNumberBean bean = picker.adapter.getSelectedValues()[0];
              telephoneModel.number = bean.mobile;
              telephoneModel.cardId = bean.id;
            },
          ).showModal(context);
        },
      );
    }
  }
}
