import 'package:csust_edu_system/ui/telephonecard/data/telephone_picker_type.dart';
import 'package:csust_edu_system/ui/telephonecard/model/telephone_picker_model.dart';
import 'package:csust_edu_system/ui/telephonecard/viewmodel/telephone_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../arch/baseview/consumer_view.dart';
import '../../../ass/string_assets.dart';
import '../viewmodel/telephone_picker_viewmodel.dart';

/// 电话卡选择器
///
/// @author wk
/// @since 2023/9/25
/// @version v1.8.8
class TelephonePickerView extends StatelessWidget {
  const TelephonePickerView({
    super.key,
    required this.title,
    required this.text,
    required this.pickerData,
    required this.size,
    required this.type,
  });

  /// 选择器标题
  final String title;

  /// 选择器的值
  final String text;

  /// 选择器列表
  final List pickerData;

  /// 选择器padding左边距size
  final double size;

  /// 选择器类型
  final TelephonePickerType type;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TelephonePickerViewModel(
          model: TelephonePickerModel(text: text, pickerData: pickerData)),
      child: ConsumerView<TelephonePickerViewModel>(
        builder: (ctx, viewModel, _) {
          viewModel.injectContext(context);
          return GestureDetector(
            child: Padding(
                padding: EdgeInsets.fromLTRB(size, 12, 0, 12),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      viewModel.model.text,
                      style: TextStyle(
                          color: viewModel.model.text
                                  .startsWith(StringAssets.clickSelect)
                              ? Colors.black54
                              : Colors.black,
                          fontSize: 16),
                    )),
                    const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                )),
            onTap: () {
              _showPicker(context, viewModel);
            },
          );
        },
      ),
    );
  }

  /// 展示telephonePicker
  ///
  /// [context] BuildContext
  /// [viewModel] TelephonePickerViewModel
  void _showPicker(BuildContext context, TelephonePickerViewModel viewModel) {
    var telephoneViewModel = context.read<TelephoneViewModel>();
    if (type == TelephonePickerType.number) {
      viewModel.getNumberList(title, text, telephoneViewModel.model.school,
          telephoneViewModel.model.package);
    } else {
      viewModel.model.picker.showPicker(context,
          title: title,
          pickerData: viewModel.model.pickerData,
          initIndex: viewModel.model.pickerData.indexOf(text),
          onConfirm: (value, index) {
        viewModel.setText(value);
        switch (type) {
          case TelephonePickerType.schoolArea:
            telephoneViewModel.model.school = value;
            break;
          case TelephonePickerType.package:
            telephoneViewModel.model.package = value;
            break;
          case TelephonePickerType.number:
            break;
          case TelephonePickerType.cardReceivingTime:
            telephoneViewModel.model.time = value;
            break;
        }
      });
    }
  }
}
