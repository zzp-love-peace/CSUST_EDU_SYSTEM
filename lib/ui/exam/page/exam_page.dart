import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/exam/jsonbean/exam_bean.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../arch/baseview/seletor_view.dart';
import '../../../ass/string_assets.dart';
import '../../../common/appbar/common_app_bar.dart';
import '../../../common/lottie/none_lottie.dart';
import '../../../common/termpicker/view/common_term_picker_view.dart';
import '../../../data/date_info.dart';
import '../../../data/stu_info.dart';
import '../model/exam_model.dart';
import '../view/exam_item_view.dart';
import '../viewmodel/exam_viewmodel.dart';

/// 考试页
///
/// @author wk
/// @since 2023/11/4
/// @version v1.8.8
class ExamPage extends StatelessWidget {
  const ExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) =>
              ExamViewModel(model: ExamModel(term: DateInfo.nowTerm))),
    ], child: const ExamHome());
  }
}

/// 考试页Home
///
/// @author wk
/// @since 2023/11/4
/// @version v1.8.8

class ExamHome extends StatelessWidget {
  const ExamHome({super.key});

  @override
  Widget build(BuildContext context) {
    ExamViewModel gradeViewModel = context.readViewModel<ExamViewModel>();
    return Scaffold(
      appBar: CommonAppBar.create(
        StringAssets.exam,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Container(
            color: Colors.white,
            height: 40,
            child: CommonTermPickerView(
              nowTerm: gradeViewModel.model.term,
              callBack: (term) {
                gradeViewModel.queryExam(StuInfo.cookie, term);
                gradeViewModel.model.term = term;
              },
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                gradeViewModel.refreshExam();
              },
              icon: const Icon(Icons.refresh, color: Colors.white)),
        ],
      ),
      body: SelectorView<ExamViewModel, List<ExamBean>>(
        selector: (ctx, viewModel) => viewModel.model.examList,
        onInit: (viewModel) {
          viewModel.queryExam(StuInfo.cookie, viewModel.model.term);
        },
        builder: (ctx, examList, _) {
          return examList.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: examList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ExamItemView(examBean: examList[index]);
                        },
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                )
              : const NoneLottie(hint: StringAssets.noDataAvailable);
        },
      ),
    );
  }
}
