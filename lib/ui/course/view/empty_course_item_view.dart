import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ui/course/model/empty_course_item_model.dart';
import 'package:csust_edu_system/ui/course/view/course_item_view.dart';
import 'package:csust_edu_system/ui/course/view/transaction_item_view.dart';
import 'package:csust_edu_system/ui/course/viewmodel/empty_course_item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/transaction_item_model.dart';
import '../viewmodel/transaction_item_view_model.dart';

/// 空课程表Item View
///
/// @author zzp
/// @since 2023/9/24
/// @version v1.8.8
class EmptyCourseItemView extends StatelessWidget {
  const EmptyCourseItemView(
      {super.key,
      required this.isToday,
      required this.time,
      required this.index,
      required this.weekNum,
      required this.term});

  /// 是否是今天的课程
  final bool isToday;

  /// 上课时间
  final String time;

  /// 课程在课程表中的位置索引
  final int index;

  /// 周数
  final int weekNum;

  /// 学期
  final String term;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                EmptyCourseItemViewModel(model: EmptyCourseItemModel())),
        ChangeNotifierProvider(
            create: (_) =>
                TransactionItemViewModel(model: TransactionItemModel())),
      ],
      child: ConsumerView<EmptyCourseItemViewModel>(
        onInit: (viewModel) {
          viewModel.initCourseOrTransaction(term, index, weekNum);
        },
        builder: (ctx, viewModel, _) {
          var courseBean = viewModel.model.courseBean;
          return courseBean == null
              ? TransactionItemView(
                  index: index, weekNum: weekNum, time: time, term: term)
              : CourseItemView(
                  isToday: isToday,
                  courseName: courseBean.name,
                  place: courseBean.place,
                  teacher: courseBean.teacher,
                  time: courseBean.time,
                  isCustom: true,
                  index: courseBean.index,
                  weekNum: courseBean.weekNum,
                  term: courseBean.term);
        },
      ),
    );
  }
}
