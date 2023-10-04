import 'package:csust_edu_system/ui/telephonecard/data/telephone_picker_type.dart';
import 'package:csust_edu_system/ui/telephonecard/model/telephone_picker_model.dart';
import 'package:csust_edu_system/ui/telephonecard/viewmodel/telephone_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';
import 'package:provider/provider.dart';

import '../../../arch/baseview/consumer_view.dart';
import '../../../ass/string_assets.dart';
import '../../../util/typedef_util.dart';
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
    this.callBack,
    required this.size,
    this.type = TelephonePickerType.common,
  });

  /// 选择器标题
  final String title;

  /// 选择器的值
  final String text;

  /// 选择器列表
  final List pickerData;

  /// 选择器padding左边距size
  final double size;

  /// 选择器回调
  final TelephonePickerCallBack? callBack;

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
              switch (type) {
                case TelephonePickerType.number:
                  var telephoneViewModel = context.read<TelephoneViewModel>();
                  viewModel.getNumberList(
                      title,
                      telephoneViewModel.model.school,
                      telephoneViewModel.model.package);
                  break;
                case TelephonePickerType.common:
                  Picker(
                    title: Text(
                      title,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    confirmText: StringAssets.ok,
                    cancelText: StringAssets.cancel,
                    adapter: PickerDataAdapter<dynamic>(
                        pickerData: viewModel.model.pickerData),
                    changeToFirst: true,
                    hideHeader: false,
                    onConfirm: (Picker picker, List value) {
                      viewModel.setText(picker.adapter.text
                          .substring(1, picker.adapter.text.length - 1));
                      callBack?.call(picker.adapter.getSelectedValues()[0]);
                    },
                  ).showModal(context);
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
