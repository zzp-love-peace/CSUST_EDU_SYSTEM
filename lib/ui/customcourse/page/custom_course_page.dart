import 'package:csust_edu_system/arch/basedata/page_result_bean.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/data/page_result_code.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/course/jsonbean/custom_course_bean.dart';
import 'package:csust_edu_system/ui/customCourse/model/custom_course_model.dart';
import 'package:csust_edu_system/ui/customcourse/view/custom_course_edittext_view.dart';
import 'package:csust_edu_system/ui/customcourse/view/custom_course_text_view.dart';
import 'package:csust_edu_system/ui/customcourse/view/save_button_view.dart';
import 'package:csust_edu_system/ui/customcourse/viewmodel/custom_course_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/dialog/select_dialog.dart';
import '../../../util/date_util.dart';

/// 自定义课程表页
///
/// @author zzp
/// @since 2023/9/22
/// @version v1.8.8
class CustomCoursePage extends StatelessWidget {
  const CustomCoursePage(
      {super.key,
      required this.weekNum,
      required this.time,
      required this.index,
      required this.courseName,
      required this.teacher,
      required this.place,
      required this.term});

  /// 课程名称
  final String courseName;

  /// 授课老师
  final String teacher;

  /// 上课地点
  final String place;

  /// 课程时间
  final String time;

  /// 课程在课程表中下标索引
  final int index;

  /// 课程周数
  final int weekNum;

  /// 课程学期
  final String term;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => CustomCourseViewModel(model: CustomCourseModel()))
      ],
      child: CustomCourseHome(
        courseName: courseName,
        teacher: teacher,
        place: place,
        time: time,
        weekNum: weekNum,
        term: term,
        index: index,
      ),
    );
  }
}

/// 自定义课程表页Home
///
/// @author zzp
/// @since 2023/9/22
/// @version v1.8.8
class CustomCourseHome extends StatefulWidget {
  const CustomCourseHome(
      {super.key,
      required this.courseName,
      required this.teacher,
      required this.place,
      required this.time,
      required this.weekNum,
      required this.term,
      required this.index});

  /// 课程名称
  final String courseName;

  /// 授课老师
  final String teacher;

  /// 上课地点
  final String place;

  /// 课程时间
  final String time;

  /// 课程周数
  final int weekNum;

  /// 课程学期
  final String term;

  /// 课程在课程表中下标索引
  final int index;

  @override
  State<CustomCourseHome> createState() => _CustomCourseHomeState();
}

class _CustomCourseHomeState extends State<CustomCourseHome> {
  /// 自定义课程表ViewModel
  late final CustomCourseViewModel _customCourseViewModel;

  /// 自定义课程表Model
  late final CustomCourseModel _customCourseModel;

  @override
  void initState() {
    super.initState();
    _customCourseViewModel = context.readViewModel<CustomCourseViewModel>();
    _customCourseModel = _customCourseViewModel.model;
    _customCourseViewModel.initData(
        widget.courseName, widget.teacher, widget.place);
  }

  @override
  void dispose() {
    _customCourseViewModel.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          StringAssets.customCourse,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (widget.courseName.isNotEmpty)
            IconButton(
                onPressed: () {
                  SelectDialog(
                    title: StringAssets.tips,
                    subTitle: StringAssets.confirmDeleteCourse,
                    okCallback: () {
                      context.pop(
                          result: PageResultBean(
                              PageResultCode.customCourseDelete, null));
                    },
                  ).showDialog();
                },
                icon: const Icon(Icons.delete, color: Colors.white))
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          CustomCourseEditTextView(
              controller: _customCourseModel.courseNameController,
              hintText: StringAssets.courseName,
              iconData: Icons.edit,
              iconColor: Colors.black54),
          const SizedBox(
            height: 20,
          ),
          CustomCourseEditTextView(
              controller: _customCourseModel.teacherController,
              hintText: StringAssets.courseTeacher,
              iconData: Icons.person,
              iconColor: Colors.blue),
          const SizedBox(
            height: 20,
          ),
          CustomCourseEditTextView(
              controller: _customCourseModel.placeController,
              hintText: StringAssets.coursePlace,
              iconData: Icons.place,
              iconColor: Colors.redAccent),
          const SizedBox(
            height: 35,
          ),
          CustomCourseTextView(
              text:
                  '第${widget.weekNum}周 ${DateUtil.indexToWeekDay(widget.index % 8)}',
              iconData: Icons.date_range_outlined,
              iconColor: Colors.green),
          const SizedBox(
            height: 35,
          ),
          CustomCourseTextView(
              text: widget.time,
              iconData: Icons.timer,
              iconColor: Colors.amberAccent),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 35, 30, 30),
            child: SaveButtonView(
              onPressed: () {
                _saveCustomCourse();
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 保存自定义课表
  void _saveCustomCourse() {
    if (_customCourseModel.courseNameController.text.isEmpty) {
      StringAssets.courseNameCannotEmpty.showToast();
      return;
    }
    var course = CustomCourseBean(
        _customCourseModel.courseNameController.text,
        _customCourseModel.placeController.text,
        _customCourseModel.teacherController.text,
        '第${widget.weekNum}周[${widget.time}]',
        widget.index,
        widget.weekNum,
        widget.term);
    context.pop(result: PageResultBean(PageResultCode.customCourseAdd, course));
  }
}
