import 'dart:convert';

import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ui/course/db/course_db_manager.dart';
import 'package:csust_edu_system/ui/course/jsonbean/db_course_bean.dart';
import 'package:csust_edu_system/ui/course/model/week_course_layout_model.dart';

import '../../../util/course_util.dart';
import '../service/course_service.dart';

/// 周课程表组件ViewModel
///
/// @author zzp
/// @since 2023/9/21
/// @version v1.8.8
class WeekCourseLayoutViewModel
    extends BaseViewModel<WeekCourseLayoutModel, CourseService> {
  WeekCourseLayoutViewModel({required super.model});

  @override
  CourseService? createService() => CourseService();

  /// 获取某一周课程表
  ///
  /// [cookie] cookie
  /// [term] 学期
  /// [weekNum] 周数
  void getWeekCourse(String cookie, String term, int weekNum) {
    CourseDBManager.db.containsCourse(term, weekNum).then((dbValue) {
      if (dbValue == null) {
        service?.getWeekCourse(
          cookie: cookie,
          term: term,
          weekNum: weekNum,
          onDataSuccess: (data, msg) {
            model.courseList = CourseUtil.changeList(data);
            String content = jsonEncode(data);
            CourseDBManager.db
                .insertCourse(DBCourseBean(term, weekNum, content));
          },
        );
      } else {
        List list = jsonDecode(dbValue.content);
        if (list.isNotEmpty) {
          model.courseList = CourseUtil.changeList(list);
        }
      }
      notifyListeners();
    });
  }
}
