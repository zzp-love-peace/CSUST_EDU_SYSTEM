import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ui/association/view/association_item_view.dart';
import 'package:csust_edu_system/ui/association/viewmodel/association_list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/association_list_model.dart';

/// 社团列表 View
///
/// @author bmc
/// @since 2023/10/29
/// @version v1.8.8
class AssociationListView extends StatelessWidget {
  const AssociationListView({super.key, required this.id});

  /// 社团类别id
  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AssociationListViewModel(model: AssociationListModel()),
      child:
          ConsumerView<AssociationListViewModel>(builder: (ctx, viewModel, _) {
        viewModel.getAssociationByTab(id);
        return ListView.builder(
            itemCount: viewModel.model.associationList.length,
            itemBuilder: (context, index) => AssociationItemView(
                assInfo: viewModel.model.associationList[index]));
      }),
    );
  }
}
