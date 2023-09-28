import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/telephonecard/viewmodel/function_list_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../util/my_util.dart';

/// 电话卡功能列表
///
/// @author wk
/// @since 2023/9/25
/// @version v1.8.8

class FunctionListView extends StatelessWidget {
  const FunctionListView({super.key, required this.list});

  /// 功能介绍列表
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return ConsumerView<FunctionListViewModel>(
        builder: (context, viewModel, _) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, top: 2),
          child: GestureDetector(
            onTap: () {
              viewModel.setIsExpanded();
            },
            child: Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  StringAssets.function,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(
                  width: 60,
                ),
                Expanded(
                  child: Text(
                    viewModel.model.isExpanded
                        ? StringAssets.packUpFunction
                        : StringAssets.launchFunction,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                viewModel.model.isExpanded
                    ? const Icon(Icons.arrow_drop_up)
                    : const Icon(Icons.arrow_drop_down),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
          ),
        ),
        viewModel.model.isExpanded
            ? const Divider(
                thickness: 1, indent: 30, endIndent: 30, color: Colors.black)
            : const SizedBox(
                height: 5,
              ),
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 2, right: 30),
          child: ImplicitlyAnimatedList<String>(
            items: viewModel.model.isExpanded ? list : [],
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            areItemsTheSame: (a, b) => a.hashCode == b.hashCode,
            itemBuilder: (context, animation, item, index) {
              return Column(
                children: [
                  buildFadeWidgetVertical(
                      Text(
                        item,
                        // style: const TextStyle(color: Colors.black, fontSize: 14)
                      ),
                      animation),
                  const Divider(
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                      color: Colors.black12),
                ],
              );
            },
            removeItemBuilder: (context, animation, oldItem) {
              return buildFadeWidgetVertical(Text(oldItem), animation);
            },
          ),
        ),
      ]);
    });
  }
}
