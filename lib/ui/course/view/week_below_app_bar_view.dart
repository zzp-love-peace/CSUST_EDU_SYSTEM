import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/course/viewmodel/course_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/picker.dart';

import '../../../data/date_info.dart';

/// 课程表AppBar下方View
///
/// 用于选择周数，展示是否为本周
///
/// @author zzp
/// @since 2023/9/20
/// @version v1.8.8
class WeekBelowAppBarView extends StatelessWidget {
  const WeekBelowAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ConsumerView<CourseViewModel>(
      builder: (ctx, courseViewModel, _) {
        final List<String> weekList = [];
        for (int i = 1; i <= DateInfo.totalWeek; i++) {
          weekList.add('第$i周');
        }
        return Row(
          children: [
            Expanded(
                flex: 1,
                child: InkWell(
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    children: [
                      Text('第${courseViewModel.model.weekNum}周',
                          style: const TextStyle(fontSize: 16)),
                      const Icon(Icons.arrow_drop_down, color: Colors.black),
                    ],
                  ),
                  onTap: () {
                    Picker(
                      title: const Text(
                        StringAssets.selectWeekNum,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      confirmText: StringAssets.ok,
                      cancelText: StringAssets.cancel,
                      selecteds: courseViewModel.model.weekSelectedIndex,
                      adapter: PickerDataAdapter<String>(pickerData: weekList),
                      changeToFirst: true,
                      hideHeader: false,
                      onConfirm: (Picker picker, List value) {
                        var week = picker.adapter.text
                            .substring(1, picker.adapter.text.length - 1);
                        var weekNum = weekList.indexOf(week) + 1;
                        courseViewModel.changeWeekNum(weekNum, value[0],
                            isNotify: false);
                        courseViewModel.model.pageController.animateToPage(
                            weekNum - 1,
                            duration: const Duration(milliseconds: 1200),
                            curve: Curves.fastOutSlowIn);
                      },
                    ).showModal(context);
                  },
                )),
            Expanded(
              flex: 1,
              child: Text(
                courseViewModel.model.weekNum == DateInfo.nowWeek &&
                        courseViewModel.model.term == DateInfo.nowTerm
                    ? StringAssets.thisWeek
                    : StringAssets.notThisWeek,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
