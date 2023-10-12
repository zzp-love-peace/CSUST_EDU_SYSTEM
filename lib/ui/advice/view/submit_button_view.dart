import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ui/advice/viewmodel/advice_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../ass/string_assets.dart';

/// 提交反馈按钮
///
/// @author bmc
/// @since 2023/9/30
/// @version v1.8.8
class SubmitButtonView extends StatelessWidget {
  const SubmitButtonView({super.key, required this.onPress});

  /// 点击事件回调
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return ConsumerView<AdviceViewModel>(
      builder: (context, viewModel, _) => Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: ElevatedButton(
          child: const Center(
            child: Text(
              StringAssets.submit,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          style: ButtonStyle(
            enableFeedback: viewModel.model.enable,
            backgroundColor: MaterialStateProperty.all(viewModel.model.enable
                ? Theme.of(context).primaryColor
                : Colors.grey),
            padding: MaterialStateProperty.all(
                const EdgeInsets.fromLTRB(0, 10, 0, 10)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
          ),
          onPressed: () {
            onPress.call();
            viewModel.checkPhoneNum();
          },
        ),
      ),
    );
  }
}
