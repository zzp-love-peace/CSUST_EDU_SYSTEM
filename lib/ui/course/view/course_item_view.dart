import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ui/course/model/course_item_model.dart';
import 'package:csust_edu_system/ui/course/viewmodel/course_item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

/// 课程表Item View
///
/// @author zzp
/// @since 2023/9/23
/// @version v1.8.8
class CourseItemView extends StatelessWidget {
  const CourseItemView(
      {super.key,
      required this.isToday,
      required this.courseName,
      required this.place,
      required this.teacher,
      required this.time,
      required this.isCustom,
      required this.index,
      required this.weekNum,
      required this.term});

  /// 是否是今天的课程
  final bool isToday;

  /// 课程名
  final String courseName;

  /// 上课地点
  final String place;

  /// 授课老师
  final String teacher;

  /// 上课时间
  final String time;

  /// 是否是自定义课表
  final bool isCustom;

  /// 课程在课程表中的位置索引
  final int index;

  /// 周数
  final int weekNum;

  /// 学期
  final String term;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CourseItemViewModel(
          model: CourseItemModel(
              courseName: courseName, teacher: teacher, place: place)),
      child: Ink(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: isToday
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(0.45)),
        child: ConsumerView<CourseItemViewModel>(
          builder: (ctx, viewModel, _) {
            return InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              onTap: () {
                if (isCustom) {
                  viewModel.pushCustomCoursePage(term, weekNum, time, index);
                } else {
                  SmartDialog.show(
                      builder: (_) => _courseDialog(viewModel.model.courseName,
                          viewModel.model.place, viewModel.model.teacher, time),
                      animationType: SmartAnimationType.scale,
                      clickMaskDismiss: false);
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      viewModel.model.courseName,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '@${viewModel.model.place}',
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// 课程表Dialog
  ///
  /// [name] 课程名
  /// [place] 上课地点
  /// [teacher] 授课老师
  /// [time] 上课时间
  Widget _courseDialog(String name, String place, String teacher, String time) {
    List splitTime = time.split('[');
    var timeOfWeek = splitTime[0];
    var timeOfDay = splitTime[1].toString().split(']')[0];
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 300,
          width: double.infinity,
          child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  _getCourseDialogIconText(
                      Icons.date_range_outlined, Colors.green, timeOfWeek),
                  _getCourseDialogIconText(
                      Icons.timer, Colors.amberAccent, timeOfDay),
                  _getCourseDialogIconText(Icons.person, Colors.blue, teacher),
                  _getCourseDialogIconText(
                      Icons.place, Colors.redAccent, place),
                ],
              ))),
    );
  }

  /// 获取课程表Dialog中的图标文字列
  ///
  /// [iconData] 图标
  /// [iconColor] 图标颜色
  /// [text] 文字内容
  Widget _getCourseDialogIconText(
      IconData iconData, Color iconColor, String text) {
    return Row(
      children: [
        Icon(
          iconData,
          color: iconColor,
        ),
        const SizedBox(
          width: 30,
        ),
        Text(text),
      ],
    );
  }
}
