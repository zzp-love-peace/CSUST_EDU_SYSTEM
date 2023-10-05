import 'package:csust_edu_system/arch/baseservice/empty_service.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/data/page_result_code.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/course/model/transaction_item_model.dart';
import 'package:provider/provider.dart';

import '../../../ass/string_assets.dart';
import '../../customcourse/page/custom_course_page.dart';
import '../jsonbean/custom_course_bean.dart';
import '../model/empty_course_item_model.dart';
import 'course_view_model.dart';
import 'empty_course_item_view_model.dart';

/// 事务Item ViewModel
///
/// @author zzp
/// @since 2023/9/23
/// @version v1.8.8
class TransactionItemViewModel
    extends BaseViewModel<TransactionItemModel, EmptyService> {
  TransactionItemViewModel({required super.model});

  /// 改变item添加课程的状态
  ///
  /// [isCourseAddActive] 是否处于可以添加课程的状态
  void changeItemCourseAddActive(bool isCourseAddActive) {
    model.isCourseAddActive = isCourseAddActive;
    notifyListeners();
  }

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
            courseName: StringAssets.emptyStr,
            teacher: StringAssets.emptyStr,
            place: StringAssets.emptyStr,
            term: term))
        .then(
      (pageResultBean) {
        if (pageResultBean != null &&
            pageResultBean.resultData != null &&
            pageResultBean.resultCode == PageResultCode.customCourseAdd) {
          var courseViewModel = context.read<CourseViewModel>();
          courseViewModel.model.customCourseList
              .add(pageResultBean.resultData!);
          courseViewModel.saveCustomCourseList();
          var emptyCourseItemViewModel =
              context.read<EmptyCourseItemViewModel>();
          emptyCourseItemViewModel.setModel(
              EmptyCourseItemModel(courseBean: pageResultBean.resultData));
        }
      },
    );
  }

  @override
  EmptyService? createService() => null;
}
