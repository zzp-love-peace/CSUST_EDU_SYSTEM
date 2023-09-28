import 'package:csust_edu_system/ui/telephonecard/model/show_picker_model.dart';
import 'package:csust_edu_system/ui/telephonecard/viewmodel/telephone_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';
import 'package:provider/provider.dart';

import '../../../arch/baseview/consumer_view.dart';
import '../../../ass/string_assets.dart';
import '../../../util/log.dart';
import '../../../util/typedef_util.dart';
import '../viewmodel/show_picker_viewmodel.dart';

/// 电话卡选择器
///
/// @author wk
/// @since 2023/9/25
/// @version v1.8.8
class ShowPickerView extends StatelessWidget {
  ShowPickerView({
    super.key,
    required this.title,
    required this.text,
    required this.pickerData,
    required this.callBack,
    required this.size,
    this.telephoneViewModel,
  });

  /// 选择器标题
  final String title;

  /// 选择器的值
  String text;

  /// 选择器列表
  final List<String> pickerData;

  /// 选择器padding左边距size
  final double size;

  /// 选择器回调
  final ShowPickerCallBack callBack;
  final TelephoneViewModel? telephoneViewModel;

  @override
  Widget build(BuildContext context) {
    if (title == StringAssets.selectNumber) {
      Log.d(pickerData.toString());
    }
    return ChangeNotifierProvider(
        create: (_) => ShowPickerViewModel(
            model: ShowPickerModel(
                title: title, text: text, pickerData: pickerData)),
        child: ConsumerView<ShowPickerViewModel>(builder: (ctx, viewModel, _) {
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
              // print(viewModel.model.pickerData);
              Picker(
                  title: Text(
                    viewModel.model.title,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  confirmText: StringAssets.ok,
                  cancelText: StringAssets.cancel,
                  adapter: PickerDataAdapter<String>(
                      pickerData: viewModel.model.pickerData),
                  changeToFirst: true,
                  hideHeader: false,
                  onConfirm: (Picker picker, List value) {
                    viewModel.setText(picker.adapter.text
                        .substring(1, picker.adapter.text.length - 1));
                    callBack.call(viewModel.model.text);
                  }).showModal(context);
            },
          );
        }));
  }
}
