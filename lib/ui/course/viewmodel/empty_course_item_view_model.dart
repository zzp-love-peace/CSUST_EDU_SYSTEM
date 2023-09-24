import 'package:csust_edu_system/arch/baseservice/empty_service.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ui/course/model/empty_course_item_model.dart';
import 'package:provider/provider.dart';

import 'course_view_model.dart';

/// 空课程表Item ViewModel
///
/// @author zzp
/// @since 2023/9/24
/// @version v1.8.8
class EmptyCourseItemViewModel
    extends BaseViewModel<EmptyCourseItemModel, EmptyService> {
  EmptyCourseItemViewModel({required super.model});

  /// 初始化该空课程表为自定义课程表或者为事务Item
  ///
  /// [term] 学期
  /// [index] 课程在课程表中下标索引
  /// [weekNum] 周数
  void initCourseOrTransaction(String term, int index, int weekNum) {
    final courseModel = context.read<CourseViewModel>().model;
    for (var course in courseModel.customCourseList) {
      if (term == course.term &&
          index == course.index &&
          weekNum == course.weekNum) {
        model.courseBean = course;
        notifyListeners();
        break;
      }
    }
  }
}
