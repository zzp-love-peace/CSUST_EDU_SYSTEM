import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/appbar/common_app_bar.dart';
import '../../../common/termpicker/view/common_term_picker_view.dart';
import '../../../data/date_info.dart';
import '../../../data/stu_info.dart';
import '../model/grade_model.dart';
import '../view/grade_center_layout.dart';
import '../view/point_below_appbar.dart';
import '../viewmodel/grade_viewmodel.dart';

/// 成绩Page
///
/// @author wk
/// @since 2023/10/28
/// @version V1.8.8
class GradePage extends StatelessWidget {
  const GradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) =>
              GradeViewModel(model: GradeModel(term: DateInfo.nowTerm))),
    ], child: const GradeHome());
  }
}

/// 成绩页Home
///
/// @author wk
/// @since 2023/10/28
/// @version V1.8.8

class GradeHome extends StatelessWidget {
  const GradeHome({super.key});

  @override
  Widget build(BuildContext context) {
    GradeViewModel gradeViewModel = context.readViewModel<GradeViewModel>();
    return Scaffold(
      appBar: CommonAppBar.create(
        StringAssets.grade,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: Container(
                color: Colors.white,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonTermPickerView(
                        nowTerm: gradeViewModel.model.term,
                        callBack: (term) {
                          gradeViewModel.queryScore(StuInfo.cookie, term);
                          gradeViewModel.model.term = term;
                        }),
                    const PointBelowAppBar()
                  ],
                ))),
        actions: [
          IconButton(
              onPressed: () {
                gradeViewModel.refreshGrade();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
      ),
      body: const GradeCenterLayout(),
    );
  }
}
