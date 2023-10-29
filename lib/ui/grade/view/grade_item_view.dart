import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:flutter/material.dart';

import '../json/grade_bean.dart';
import '../viewmodel/grade_viewmodel.dart';

/// 成绩列表Item
///
/// @author wk
/// @since 2023/10/28
/// @version v1.8.8
class GradeItemView extends StatelessWidget {
  /// 成绩详情数据
  final GradeBean gradeBean;
  /// 成绩列表索引
  final int position;

  const GradeItemView(
      {super.key, required this.gradeBean, required this.position});

  @override
  Widget build(BuildContext context) {
    var gradeViewModel = context.readViewModel<GradeViewModel>();
    return Column(
      children: [
        ListTile(
          tileColor: Colors.white,
          leading: Icon(
            Icons.arrow_right,
            color: Colors.black.withOpacity(0.7),
            size: 36,
          ),
          title: Text(gradeBean.courseName,
              style: const TextStyle(color: Colors.black)),
          trailing: Text(
            gradeBean.score,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onTap: () {
            gradeViewModel.queryScoreInfo(
                StuInfo.cookie, gradeBean.gradeInfoUrl, position);
          },
        ),
      ],
    );
  }
}
