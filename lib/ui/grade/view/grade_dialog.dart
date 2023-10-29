import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/grade/json/grade_info_bean.dart';
import 'package:flutter/material.dart';

import '../json/grade_bean.dart';

/// 成绩详情Dialog
///
/// @author wk
/// @since 2023/10/28
/// @version v1.8.8
class GradeDialog extends StatelessWidget {
  const GradeDialog({super.key, required this.data, required this.infoData});

  final GradeBean data;
  final GradeInfoBean infoData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 450,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  data.courseName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                _row(title: StringAssets.xuefen, value: data.xuefen),
                _row(title: StringAssets.point, value: data.point),
                _row(
                    title: StringAssets.courseNature,
                    value: data.property + " " + data.nature),
                _row(
                    title: StringAssets.normalGrade,
                    value: infoData.normalGrade),
                _row(
                    title: StringAssets.normalGradePer,
                    value: infoData.normalGradePer),
                _row(
                    title: StringAssets.middleGrade,
                    value: infoData.middleGrade),
                _row(
                    title: StringAssets.middleGradePer,
                    value: infoData.middleGradePer),
                _row(
                    title: StringAssets.finalGrade, value: infoData.finalGrade),
                _row(
                    title: StringAssets.finalGradePer,
                    value: infoData.finalGradePer),
              ],
            ),
          )),
    );
  }

  /// 获取带Text的Row
  ///
  /// [title] 标题
  /// [value] 值
  Widget _row({required String title, required String value}) {
    return Row(
      children: [Text(title), const SizedBox(width: 10), Text(value)],
    );
  }
}
