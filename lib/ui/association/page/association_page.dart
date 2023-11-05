import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/ui/association/model/association_model.dart';
import 'package:csust_edu_system/ui/association/view/association_list_view.dart';
import 'package:csust_edu_system/ui/association/viewmodel/association_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 社团页
///
/// @author bmc
/// @since 2023/10/29
/// @version v1.8.8
class AssociationPage extends StatelessWidget {
  const AssociationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AssociationViewModel(model: AssociationModel()),
        child: const AssociationHome());
  }
}

/// 社团页Home
///
/// @author bmc
/// @since 2023/10/29
/// @version v1.8.8
class AssociationHome extends StatelessWidget {
  const AssociationHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ConsumerView<AssociationViewModel>(
      onInit: (viewModel) {
        viewModel.getAssociationTabList();
      },
      builder: (ctx, viewModel, _) {
        return DefaultTabController(
          length: viewModel.model.tabList.length,
          child: Scaffold(
            appBar: CommonAppBar.create(
              StringAssets.association,
              bottom: TabBar(
                labelColor: Colors.white,
                labelStyle: const TextStyle(fontSize: 16),
                tabs: viewModel.model.tabList
                    .map((tabBean) => Tab(text: tabBean.categoryName))
                    .toList(),
                isScrollable: true,
              ),
            ),
            body: TabBarView(
              children: viewModel.model.tabList
                  .map((tabBean) => AssociationListView(id: tabBean.id))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
