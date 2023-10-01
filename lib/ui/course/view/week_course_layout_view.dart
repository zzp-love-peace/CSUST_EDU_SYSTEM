import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/ui/course/model/week_course_layout_model.dart';
import 'package:csust_edu_system/ui/course/view/course_item_view.dart';
import 'package:csust_edu_system/ui/course/view/empty_course_item_view.dart';
import 'package:csust_edu_system/ui/course/viewmodel/week_course_layout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/date_info.dart';
import '../../../util/date_util.dart';
import 'date_and_week_item_view.dart';

/// 周课程表组件View
///
/// @author zzp
/// @since 2023/9/21
/// @version v1.8.8
class WeekCourseLayoutView extends StatelessWidget {
  const WeekCourseLayoutView(
      {super.key,
      required this.year,
      required this.month,
      required this.day,
      required this.term,
      required this.weekNum});

  /// 年
  final int year;

  /// 月
  final int month;

  /// 日
  final int day;

  /// 学期
  final String term;

  /// 周数
  final int weekNum;

  @override
  Widget build(BuildContext context) {
    var itemWidth = (MediaQuery.of(context).size.width - 31) / 8;
    var itemHeight = 120.0;
    var childAspectRatio = itemWidth / itemHeight;
    return ChangeNotifierProvider(
      create: (_) => WeekCourseLayoutViewModel(model: WeekCourseLayoutModel()),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              children: _dateAndWeekTab(
                day,
                month,
                year,
              ),
            ),
          ),
          Expanded(
            child: ConsumerView<WeekCourseLayoutViewModel>(
              onInit: (viewModel) {
                viewModel.getWeekCourse(StuInfo.cookie, term, weekNum);
              },
              builder: (ctx, viewModel, _) {
                return viewModel.model.courseList.isNotEmpty
                    ? GridView.builder(
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8,
                          mainAxisSpacing: 3.0,
                          crossAxisSpacing: 3.0,
                          childAspectRatio: childAspectRatio,
                        ),
                        itemCount: 40,
                        itemBuilder: (context, position) {
                          return _getCourseItem(context, position);
                        },
                      )
                    : Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 日期星期Tab
  ///
  /// [dayOfSunday] 周日是多少号
  /// [monthOfSunday] 周日是哪个月
  /// [yearOfSunday] 周日是哪一年
  List<Widget> _dateAndWeekTab(
      int dayOfSunday, int monthOfSunday, int yearOfSunday) {
    List<Widget> result = [];
    List<int> today = DateUtil.splitDate(DateInfo.nowDate);
    bool isNowTerm = term == DateInfo.nowTerm;
    for (int i = 0; i < 8; i++) {
      Widget widget;
      String stringOfDate;
      int date =
          DateUtil.addDay(yearOfSunday, monthOfSunday, dayOfSunday, i - 1)[2];
      if (isNowTerm) {
        stringOfDate = date.toString();
      } else {
        stringOfDate = StringAssets.emptyStr;
      }
      bool isToday;
      if (isNowTerm && today[2] == date) {
        int m = date >= dayOfSunday ? monthOfSunday : monthOfSunday + 1;
        if (today[1] == m) {
          isToday = true;
        } else {
          isToday = false;
        }
      } else {
        isToday = false;
      }
      switch (i) {
        case 0:
          widget = isNowTerm && DateInfo.nowWeek != -1
              ? DateAndWeekItemView(
                  week: monthOfSunday.toString(),
                  date: StringAssets.month,
                  isToday: false)
              : const DateAndWeekItemView(
                  week: StringAssets.emptyStr,
                  date: StringAssets.emptyStr,
                  isToday: false);
          break;
        case 1:
          widget = DateAndWeekItemView(
            week: StringAssets.Sunday,
            date: stringOfDate,
            isToday: isToday,
          );
          break;
        case 2:
          widget = DateAndWeekItemView(
            week: StringAssets.Monday,
            date: stringOfDate,
            isToday: isToday,
          );
          break;
        case 3:
          widget = DateAndWeekItemView(
              week: StringAssets.Tuesday, date: stringOfDate, isToday: isToday);
          break;
        case 4:
          widget = DateAndWeekItemView(
              week: StringAssets.Wednesday,
              date: stringOfDate,
              isToday: isToday);
          break;
        case 5:
          widget = DateAndWeekItemView(
            week: StringAssets.Thursday,
            date: stringOfDate,
            isToday: isToday,
          );
          break;
        case 6:
          widget = DateAndWeekItemView(
            week: StringAssets.Friday,
            date: stringOfDate,
            isToday: isToday,
          );
          break;
        case 7:
          widget = DateAndWeekItemView(
            week: StringAssets.Saturday,
            date: stringOfDate,
            isToday: isToday,
          );
          break;
        default:
          widget = Container();
          break;
      }
      result.add(widget);
    }
    return result;
  }

  /// 获取课程item
  ///
  /// [context] context
  /// [index] 课程在课程表中下标索引
  Widget _getCourseItem(BuildContext context, int index) {
    if (index % 8 == 0) {
      return _getTimeItem(index, Theme.of(context).primaryColor);
    }
    final weekCourseLayoutModel =
        context.read<WeekCourseLayoutViewModel>().model;
    int i = (DateUtil.date2Week(DateInfo.nowDate) + 1) % 8;
    bool isToday = i == (index % 8) &&
        weekNum == DateInfo.nowWeek &&
        term == DateInfo.nowTerm;
    if (weekCourseLayoutModel.courseList[index ~/ 8][index % 8] != null) {
      var value = weekCourseLayoutModel.courseList[index ~/ 8][index % 8];
      return CourseItemView(
        courseName: value[KeyAssets.courseName],
        time: value[KeyAssets.time],
        isToday: isToday,
        place: value[KeyAssets.address],
        teacher: value[KeyAssets.teacher],
        isCustom: false,
        index: index,
        weekNum: weekNum,
        term: term,
      );
    } else {
      int start = (index ~/ 8 + 1) * 2 - 1;
      int end = (index ~/ 8 + 1) * 2;
      String startStr = start < 10 ? '0$start' : start.toString();
      String endStr = end < 10 ? '0$end' : end.toString();
      return EmptyCourseItemView(
          isToday: isToday,
          time: '$startStr-$endStr节',
          index: index,
          weekNum: weekNum,
          term: term);
    }
  }

  /// 课程时间item
  ///
  /// [index] 课程在课程表中下标索引
  /// [textColor] 文字颜色
  Widget _getTimeItem(int index, Color textColor) {
    int t = (index ~/ 8) * 2 + 1;
    String startTime1 = StringAssets.emptyStr;
    String endTime1 = StringAssets.emptyStr;
    String startTime2 = StringAssets.emptyStr;
    String endTime2 = StringAssets.emptyStr;
    switch (t) {
      case 1:
        startTime1 = StringAssets.time_8_00;
        endTime1 = StringAssets.time_8_45;
        startTime2 = StringAssets.time_8_55;
        endTime2 = StringAssets.time_9_40;
        break;
      case 3:
        startTime1 = StringAssets.time_10_10;
        endTime1 = StringAssets.time_10_55;
        startTime2 = StringAssets.time_11_05;
        endTime2 = StringAssets.time_11_50;
        break;
      case 5:
        startTime1 = StringAssets.time_14_00;
        endTime1 = StringAssets.time_14_45;
        startTime2 = StringAssets.time_14_55;
        endTime2 = StringAssets.time_15_40;
        break;
      case 7:
        startTime1 = StringAssets.time_16_10;
        endTime1 = StringAssets.time_16_55;
        startTime2 = StringAssets.time_17_05;
        endTime2 = StringAssets.time_17_50;
        break;
      case 9:
        startTime1 = StringAssets.time_19_30;
        endTime1 = StringAssets.time_20_15;
        startTime2 = StringAssets.time_20_25;
        endTime2 = StringAssets.time_21_10;
        break;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _getTimeItemText(t, startTime1, endTime1, textColor),
          _getTimeItemText(t + 1, startTime2, endTime2, textColor),
        ],
      ),
    );
  }

  /// 课程时间item text
  ///
  /// [number] 课程序号
  /// [startTime] 课程开始时间
  /// [endTime] 课程结束时间
  /// [textColor] 文字颜色
  Widget _getTimeItemText(
      int number, String startTime, String endTime, Color textColor) {
    return Column(
      children: [
        Text(
          number.toString(),
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          startTime,
          style: TextStyle(fontSize: 12, color: textColor),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          endTime,
          style: TextStyle(fontSize: 12, color: textColor),
        ),
      ],
    );
  }
}
