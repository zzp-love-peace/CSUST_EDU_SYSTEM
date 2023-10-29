import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ui/association/view/association_item_view.dart';
import 'package:csust_edu_system/ui/association/viewmodel/association_view_model.dart';
import 'package:flutter/cupertino.dart';
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
    return ConsumerView<AssociationViewModel>(builder: (ctx, viewModel,_) {
      return ListView.builder(
      itemCount: viewModel.model.associationList.length,
      itemBuilder: (context, index) => AssociationItemView(assInfo: viewModel.model.associationList[index]));
    }
  );
  }
}
