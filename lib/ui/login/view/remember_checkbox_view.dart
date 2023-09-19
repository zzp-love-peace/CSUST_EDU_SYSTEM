import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/login/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';

/// 记住密码单选框
///
/// @author zzp
/// @since 2023/9/12
/// @version v1.8.8
class RememberCheckBox extends StatelessWidget {
  const RememberCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ConsumerView<LoginViewModel>(builder: (context, viewModel, _) => Checkbox(
              value: viewModel.model.isRemember,
              onChanged: (value) {
                if (value != null) {
                  viewModel.setIsRemember(value);
                }
              })),
          const Text(
            StringAssets.rememberPasswordAndAutoLogin,
            style: TextStyle(fontSize: 14, color: Colors.black),
          )
        ]
    );
  }
}
