import 'package:csust_edu_system/arch/baseview/seletor_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/grade/view/grade_item_view.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/lottie/none_lottie.dart';
import '../../../data/stu_info.dart';
import '../viewmodel/grade_viewmodel.dart';

/// 成绩页成绩列表
///
/// @author wk
/// @since 2023/10/28
/// @version v1.8.8
class GradeCenterLayout extends StatelessWidget {
  const GradeCenterLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectorView<GradeViewModel, List>(
        selector: (ctx, viewModel) => viewModel.model.gradeList,
        onInit: (viewModel) {
          viewModel.queryScore(StuInfo.cookie, viewModel.model.term);
        },
        builder: (ctx, gradeList, _) {
          return gradeList.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: gradeList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GradeItemView(
                            gradeBean: gradeList[index], position: index);
                      },
                    )),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                    child: Text(
                      StringAssets.gradeTips,
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              )
            ],
          )
              : const NoneLottie(hint: StringAssets.noDataAvailable);
        });
  }
}
