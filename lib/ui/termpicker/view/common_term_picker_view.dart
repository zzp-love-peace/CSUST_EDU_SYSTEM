import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/termpicker/model/common_term_picker_model.dart';
import 'package:csust_edu_system/ui/termpicker/viewmodel/common_term_picker_view_model.dart';
import 'package:csust_edu_system/utils/typedef_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';
import 'package:provider/provider.dart';

import '../../../data/stu_info.dart';

/// 通用学期选择器
///
/// 1.课程表页
/// 2.成绩页
/// 3.考试安排页
///
/// @author zzp
/// @since 2023/9/20
/// @version v1.8.8
class CommonTermPickerView extends StatelessWidget {
  const CommonTermPickerView(
      {super.key, required this.nowTerm, required this.callBack});

  /// 选择器回调
  final DatePickerCallBack callBack;
  /// 当前学期
  final String nowTerm;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            CommonTermPickerViewModel(
                model: CommonTermPickerModel(nowTerm: nowTerm)),
        child: ConsumerView<CommonTermPickerViewModel>(
            onInit: (viewModel) {
              viewModel.getAllTerm(StuInfo.cookie);
            },
            builder: (ctx, viewModel, _) {
              return GestureDetector(
                child: Row(
                  children: [
                    const SizedBox(width: 15,),
                    const Icon(Icons.date_range,),
                    const SizedBox(width: 5,),
                    Text(nowTerm, style: const TextStyle(fontSize: 17),),
                    const SizedBox(width: 5,),
                    const Icon(Icons.arrow_drop_down)
                  ],
                ),
                onTap: () {
                  if (StuInfo.cookie.isEmpty) return;
                  Picker(
                      title: const Text(StringAssets.selectTerm,
                        style: TextStyle(fontSize: 18, color: Colors.black),),
                      confirmText: StringAssets.ok,
                      cancelText: StringAssets.cancel,
                      selecteds: viewModel.model.selected,
                      adapter: PickerDataAdapter<String>(
                          pickerData: viewModel.model.allTerm),
                      changeToFirst: true,
                      hideHeader: false,
                      onConfirm: (Picker picker, List value) {
                        viewModel.setNowTerm(
                            picker.adapter.text.substring(1, picker
                                .adapter.text.length - 1));
                        viewModel.model.selected = [value[0]];
                        callBack.call(viewModel.model.nowTerm);
                      }
                  ).showModal(context); //_scaffoldKey.currentState);
                },
              );
            }));
  }
}
