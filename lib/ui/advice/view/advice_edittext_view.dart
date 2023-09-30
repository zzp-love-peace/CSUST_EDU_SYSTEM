import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:flutter/material.dart';
import '../../../ass/string_assets.dart';
import '../viewmodel/advice_viewmodel.dart';

/// 意见或建议输入框
///
/// @author bmc
/// @since 2023.9.30
/// @version v1.8.8
class AdviceEdittextView extends StatelessWidget {
  const AdviceEdittextView({super.key, required this.controller});

  /// 控制器
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ConsumerView<AdviceViewModel>(
      builder: (context, viewModel, _) => Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              minLines: 3,
              maxLines: 10,
              maxLength: 100,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: StringAssets.advice,
                errorText: null,
              ),
              onChanged: (value) {
                viewModel.changeEnable();
              }),
        ),
      ]),
    );
  }
}
