import 'package:csust_edu_system/arch/baseview/seletor_view.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/common/termpicker/view/common_term_picker_view.dart';
import 'package:csust_edu_system/data/date_info.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/course/model/course_model.dart';
import 'package:csust_edu_system/ui/course/view/course_progress_dialog_view.dart';
import 'package:csust_edu_system/ui/course/view/week_below_app_bar_view.dart';
import 'package:csust_edu_system/ui/course/view/week_course_layout_view.dart';
import 'package:csust_edu_system/ui/course/viewmodel/course_view_model.dart';
import 'package:csust_edu_system/ui/themecolor/page/theme_color_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ass/string_assets.dart';
import '../../../util/date_util.dart';
import '../../notification/page/notification_page.dart';

/// 课程表页
///
/// @author zzp
/// @since 2023/9/20
/// @version v1.8.8
class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => CourseViewModel(
              model: CourseModel(
                  weekNum: DateInfo.nowWeek, term: DateInfo.nowTerm))),
    ], child: const CourseHome());
  }
}

/// 课程表页Home
///
/// @author zzp
/// @since 2023/9/20
/// @version v1.8.8
class CourseHome extends StatefulWidget {
  const CourseHome({super.key});

  @override
  State<CourseHome> createState() => _CourseHomeState();
}

class _CourseHomeState extends State<CourseHome> {
  /// 课程表ViewModel
  late CourseViewModel courseViewModel;

  /// 课程表Model
  late CourseModel courseModel;

  @override
  void initState() {
    super.initState();
    courseViewModel = context.readViewModel<CourseViewModel>();
    courseModel = courseViewModel.model;
    courseViewModel.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _coursePageAppBar(),
      body: SelectorView<CourseViewModel, String>(
        selector: (ctx, viewModel) => viewModel.model.term,
        builder: (ctx, term, _) {
          return PageView.builder(
            controller: courseModel.pageController,
            itemCount: DateInfo.totalWeek,
            itemBuilder: (context, index) {
              List<int> date = DateUtil.getSunday(DateInfo.nowDate);
              List<int> d;
              int weekNum = index + 1;
              if (weekNum < DateInfo.nowWeek) {
                d = DateUtil.minusDay(date[0], date[1], date[2],
                    (DateInfo.nowWeek - weekNum) * 7);
              } else if (weekNum == DateInfo.nowWeek) {
                d = date;
              } else {
                d = DateUtil.addDay(date[0], date[1], date[2],
                    (weekNum - DateInfo.nowWeek) * 7);
              }
              return WeekCourseLayoutView(
                  year: d[0],
                  month: d[1],
                  day: d[2],
                  weekNum: weekNum,
                  term: term);
            },
            onPageChanged: (index) {
              courseViewModel.changeWeekNum(index + 1, index);
            },
          );
        },
      ),
    );
  }

  /// 课程表页AppBar
  AppBar _coursePageAppBar() => CommonAppBar.create(
    StringAssets.course,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Container(
            color: Colors.white,
            height: 40,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: CommonTermPickerView(
                    nowTerm: courseModel.term,
                    callBack: courseViewModel.termPickerCallback,
                  ),
                ),
                const Expanded(flex: 4, child: WeekBelowAppBarView())
              ],
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            context.push(const NotificationPage());
          },
          icon: const Icon(
            Icons.notifications,
          ),
        ),
        actions: [
          PopupMenuButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            icon: const Icon(Icons.refresh),
            iconSize: 24,
            tooltip: StringAssets.emptyStr,
            onSelected: (value) {
              switch (value) {
                case 0:
                  courseViewModel.getWeekCourseToDB(
                      StuInfo.cookie, courseModel.term, courseModel.weekNum);
                  break;
                case 1:
                  CourseProgressDialogView(term: courseModel.term).showDialog();
                  break;
              }
            },
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                const PopupMenuItem(
                  value: 0,
                  child: Text(StringAssets.refreshNowWeek),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text(StringAssets.refreshNowTerm),
                ),
              ];
            },
          ),
          IconButton(
            onPressed: () {
              context.push(const ThemeColorPage());
            },
            icon: const Icon(Icons.color_lens),
          ),
        ],
      );
}
