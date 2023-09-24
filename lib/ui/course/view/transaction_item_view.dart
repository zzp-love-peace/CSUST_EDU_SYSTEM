import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ui/course/viewmodel/transaction_item_view_model.dart';
import 'package:flutter/material.dart';

/// 事务Item View（课程表中空白课程）
///
/// @author zzp
/// @since 2023/9/23
/// @version v1.8.8
class TransactionItemView extends StatelessWidget {
  const TransactionItemView(
      {super.key,
      required this.index,
      required this.weekNum,
      required this.time,
      required this.term});

  /// 课程在课程表中下标索引
  final int index;

  /// 周数
  final int weekNum;

  /// 上课时间
  final String time;

  /// 学期
  final String term;

  @override
  Widget build(BuildContext context) {
    return ConsumerView<TransactionItemViewModel>(
      builder: (ctx, viewModel, _) {
        return Ink(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: viewModel.model.isCourseAddActive
                  ? Theme.of(context).primaryColor.withOpacity(0.2)
                  : Colors.transparent),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            onTap: () {
              if (!viewModel.model.isCourseAddActive) {
                Future.delayed(const Duration(milliseconds: 3000), () {
                  viewModel.changeItemCourseAddActive(false);
                });
              } else {
                viewModel.pushCustomCoursePage(term, weekNum, time, index);
              }
              viewModel.changeItemCourseAddActive(
                  !viewModel.model.isCourseAddActive);
            },
            child: viewModel.model.isCourseAddActive
                ? const Center(
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.grey,
                    ),
                  )
                : Container(),
          ),
        );
      },
    );
  }
}
