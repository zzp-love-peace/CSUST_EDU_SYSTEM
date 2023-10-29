import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/grade/view/grade_item_view.dart';
import 'package:flutter/cupertino.dart';

import '../../../arch/baseview/consumer_view.dart';
import '../../../common/lottie/none_lottie.dart';
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
    return ConsumerView<GradeViewModel>(builder: (ctx, viewModel, _) {
      return viewModel.model.gradeList.isNotEmpty
          ? Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: viewModel.model.gradeList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GradeItemView(
                        gradeBean: viewModel.model.gradeList[index],
                        position: index);
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
