import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ui/advice/viewmodel/advice_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../ass/string_assets.dart';

/// 手机号填写框
///
/// @author bmc
/// @since 2023/9/23
/// @version v1.8.8
class PhoneNumEdittextView extends StatelessWidget {
  const PhoneNumEdittextView({super.key, required this.controller});

  //控制器
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ConsumerView<AdviceViewModel>(
      builder: (context, viewModel, _) => Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              maxLines: 1,
              maxLength: 11,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                labelText: StringAssets.phone,
                errorText: viewModel.checkPhoneNum(controller.text),
              ),
              onChanged: (value) {
                viewModel.chageEnable();
              }),
        ),
      ]),
    );
  }
}
