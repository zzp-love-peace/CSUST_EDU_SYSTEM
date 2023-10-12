import 'package:csust_edu_system/ui/advice/viewmodel/advice_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ass/string_assets.dart';

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
    return TextField(
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
          context.read<AdviceViewModel>().changeEnable();
        });
  }
}
