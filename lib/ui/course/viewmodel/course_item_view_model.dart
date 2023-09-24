import 'package:csust_edu_system/arch/baseservice/empty_service.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/data/page_result_code.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/course/model/course_item_model.dart';
import 'package:csust_edu_system/ui/course/model/empty_course_item_model.dart';
import 'package:provider/provider.dart';

import '../../customcourse/page/custom_course_page.dart';
import '../jsonbean/custom_course_bean.dart';
import 'course_view_model.dart';
import 'empty_course_item_view_model.dart';

/// 课程表Item ViewModel
///
/// @author zzp
/// @since 2023/9/23
/// @version v1.8.8
class CourseItemViewModel extends BaseViewModel<CourseItemModel, EmptyService> {
  CourseItemViewModel({required super.model});

  /// 跳转到自定义课表页
  ///
  /// [term] 学期
  /// [weekNum] 周数
  /// [time] 上课时间
  /// [index] 课程在课程表中的下标索引
  void pushCustomCoursePage(String term, int weekNum, String time, int index) {
    context
        .push<CustomCourseBean?>(CustomCoursePage(
            weekNum: weekNum,
            time: time,
            index: index,
            courseName: model.courseName,
            teacher: model.teacher,
            place: model.place,
            term: term))
        .then((pageResultBean) {
      if (pageResultBean != null) {
        var courseViewModel = context.read<CourseViewModel>();
        if (pageResultBean.resultCode == PageResultCode.customCourseAdd) {
          var courseBean = pageResultBean.resultData!;
          for (var course in courseViewModel.model.customCourseList) {
            if (courseBean.term == course.term &&
                courseBean.index == course.index &&
                courseBean.weekNum == course.weekNum) {
              course.place = courseBean.place;
              course.teacher = courseBean.teacher;
              course.time = courseBean.time;
              course.name = courseBean.name;
              break;
            }
          }
          setModel(CourseItemModel(
              courseName: courseBean.name,
              teacher: courseBean.teacher,
              place: courseBean.place));
        } else if (pageResultBean.resultCode ==
            PageResultCode.customCourseDelete) {
          for (var course in courseViewModel.model.customCourseList) {
            if (term == course.term &&
                index == course.index &&
                weekNum == course.weekNum) {
              courseViewModel.model.customCourseList.remove(course);
              break;
            }
          }
          var emptyCourseItemViewModel =
              context.read<EmptyCourseItemViewModel>();
          emptyCourseItemViewModel.setModel(EmptyCourseItemModel());
        }
        courseViewModel.saveCustomCourseList();
      }
    });
  }
}
