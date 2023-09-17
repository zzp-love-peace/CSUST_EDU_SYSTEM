import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ui/login/viewmodel/password_edittext_viewmodel.dart';
import 'package:flutter/material.dart';

/// 密码输入框
///
/// @author zzp
/// @since 2023/9/12
class PasswordEditTextView extends StatelessWidget {
  const PasswordEditTextView({super.key, required this.controller});

  /// 控制器
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ConsumerView<PasswordEditTextViewModel>(
        builder: (context, viewModel, _) => TextField(
            controller: controller,
            obscureText: viewModel.model.passwordVisible,
            maxLines: 1,
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: "密码",
                suffixIcon: IconButton(
                    onPressed: () {
                      viewModel.changePasswordVisible();
                    },
                    icon: viewModel.model.passwordVisible
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          )
                        : const Icon(Icons.visibility_off),
                    color: Colors.grey
                )
            )
        )
    );
  }
}
