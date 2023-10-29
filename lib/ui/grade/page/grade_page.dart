import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/appbar/common_app_bar.dart';
import '../../../common/termpicker/view/common_term_picker_view.dart';
import '../../../data/date_info.dart';
import '../../../data/stu_info.dart';
import '../model/grade_model.dart';
import '../view/grade_center_layout.dart';
import '../view/grade_page_appbar.dart';
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

class GradeHome extends StatefulWidget {
  const GradeHome({super.key});

  @override
  State<StatefulWidget> createState() => _GradeHomeState();
}

class _GradeHomeState extends State<GradeHome> {
  late GradeViewModel gradeViewModel;
  late GradeModel gradeModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _gradeAppBar(),
      body: const GradeCenterLayout(),
    );
  }

  @override
  void initState() {
    super.initState();
    gradeViewModel = context.readViewModel<GradeViewModel>();
    gradeModel = gradeViewModel.model;
    gradeViewModel.queryScore(StuInfo.cookie, gradeModel.term);
  }

  AppBar _gradeAppBar() => CommonAppBar.create(
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
                    const GradePageAppBar()
                  ],
                ))),
        actions: [
          IconButton(
              onPressed: () {
                var now = DateTime.now().millisecondsSinceEpoch;
                if (now - gradeViewModel.model.lastClick < 1500) return;
                gradeViewModel.model.lastClick = now;
                gradeViewModel.queryScore(
                    StuInfo.cookie, gradeViewModel.model.term);
                StringAssets.refreshSuccess.showToast();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
      );
}
