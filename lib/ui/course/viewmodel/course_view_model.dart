import 'dart:convert';

import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/course/db/course_db_manager.dart';
import 'package:csust_edu_system/ui/course/jsonbean/custom_course_bean.dart';
import 'package:csust_edu_system/ui/course/jsonbean/db_course_bean.dart';
import 'package:csust_edu_system/ui/course/model/course_model.dart';
import 'package:csust_edu_system/ui/course/service/course_service.dart';
import 'package:csust_edu_system/util/sp/sp_util.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/dialog/hint_dialog.dart';
import '../../../data/date_info.dart';

/// 课程表ViewModel
///
/// @author zzp
/// @since 2023/9/20
/// @version v1.8.8
class CourseViewModel extends BaseViewModel<CourseModel, CourseService> {
  CourseViewModel({required super.model});

  @override
  CourseService? createService() => CourseService();

  /// 初始化数据
  void initData() {
    if (DateInfo.nowWeek > 0) {
      model.weekSelectedIndex.clear();
      model.weekSelectedIndex.add(DateInfo.nowWeek - 1);
    }
    String myCourseData =
        SpUtil.get<String>(KeyAssets.myCourseData, StringAssets.emptyStr);
    List jsonList;
    try {
      jsonList = jsonDecode(myCourseData);
    } on FormatException {
      jsonList = [];
    }
    var customCourses =
        jsonList.map((json) => CustomCourseBean.fromJson(json)).toList();
    model.customCourseList.addAll(customCourses);
  }

  /// 改变周数
  ///
  /// [weekNum] 周数
  /// [selectedIndex] 周数选择器index
  /// [isNotify] 是否需要notify
  void changeWeekNum(int weekNum, int selectedIndex, {bool isNotify = true}) {
    model.weekNum = weekNum;
    model.weekSelectedIndex.clear();
    model.weekSelectedIndex.add(selectedIndex);
    if (isNotify) {
      notifyListeners();
    }
  }

  /// 学期选择器回调
  ///
  /// [term] 学期
  void termPickerCallback(String term) {
    model.term = term;
    if (term != DateInfo.nowTerm) {
      model.weekNum = 1;
    } else {
      model.weekNum = DateInfo.nowWeek;
    }
    model.pageController.jumpToPage(model.weekNum - 1);
    // 选择学期前若是第一周，学期刷新后，page并不会改变，需要next后再pre强制刷新
    if (model.pageController.page == 0) {
      model.pageController
          .nextPage(
              duration: const Duration(milliseconds: 40), curve: Curves.easeIn)
          .whenComplete(() => model.pageController.previousPage(
              duration: const Duration(milliseconds: 1), curve: Curves.easeIn));
    }
    notifyListeners();
  }

  /// 获取某一周课程表，并存入数据库
  ///
  /// [cookie] cookie
  /// [term] 学期
  /// [weekNum] 周数
  void getWeekCourseToDB(String cookie, String term, int weekNum) {
    service?.getWeekCourse(
      cookie: cookie,
      term: term,
      weekNum: weekNum,
      onDataSuccess: (data, msg) async {
        String content = jsonEncode(data);
        var dbValue = await CourseDBManager.db.containsCourse(term, weekNum);
        if (dbValue == null) {
          await CourseDBManager.db
              .insertCourse(DBCourseBean(term, weekNum, content));
        } else {
          await CourseDBManager.db.updateCourse(content, dbValue.id);
        }
        const HintDialog(
          title: StringAssets.tips,
          subTitle: StringAssets.refreshSuccess,
        ).showDialog();
      },
    );
  }

  /// 刷新本学期课表
  ///
  ///
  void refreshTermCourse() {}

  /// 保存自定义课程表List
  void saveCustomCourseList() {
    List list =
        model.customCourseList.map((course) => course.toJson()).toList();
    String jsonData = jsonEncode(list);
    SpUtil.put(KeyAssets.myCourseData, jsonData);
  }
}
