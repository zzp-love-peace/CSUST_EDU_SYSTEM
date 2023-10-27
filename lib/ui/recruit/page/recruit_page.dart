import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/recruit/model/recruit_model.dart';
import 'package:csust_edu_system/ui/recruit/view/recruit_item_view.dart';
import 'package:csust_edu_system/ui/recruit/viewmodel/recruit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/lottie/none_lottie.dart';

/// 兼职页
///
/// @author zzp
/// @since 2023/10/27
/// @version v1.8.8
class RecruitPage extends StatelessWidget {
  const RecruitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RecruitViewModel(model: RecruitModel()),
        child: const RecruitHome());
  }
}

/// 兼职Home
///
/// @author zzp
/// @since 2023/10/27
/// @version v1.8.8
class RecruitHome extends StatelessWidget {
  const RecruitHome({super.key});

  @override
  Widget build(BuildContext context) {
    var recruitViewModel = context.read<RecruitViewModel>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: AnimatedSearchBar(
          label: StringAssets.recruit,
          searchStyle: const TextStyle(
            color: Colors.white,
          ),
          searchDecoration: const InputDecoration(
            border: InputBorder.none,
            hintText: StringAssets.recruitSearchTips,
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          labelStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              recruitViewModel.getRecruitInfoByTitle(value);
            } else {
              recruitViewModel.getAllRecruitInfo();
            }
          },
        ),
      ),
      body: ConsumerView<RecruitViewModel>(
        onInit: (viewModel) {
          viewModel.getAllRecruitInfo();
        },
        builder: (ctx, viewModel, _) {
          return viewModel.model.recruitList.isNotEmpty
              ? ListView.builder(
                  itemCount: viewModel.model.recruitList.length,
                  itemBuilder: (context, index) => RecruitItemView(
                    recruitBean: viewModel.model.recruitList[index],
                  ),
                )
              : const NoneLottie(
                  hint: StringAssets.noInformation,
                );
        },
      ),
    );
  }
}
