import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/association/jsonbean/association_info_bean.dart';
import 'package:csust_edu_system/ui/association/model/association_list_model.dart';
import 'package:csust_edu_system/ui/association/service/association_list_service.dart';

import '../../../arch/baseviewmodel/base_view_model.dart';

/// 社团列表ViewModel
///
/// @author bmc
/// @since 2023/10/29
/// @version v1.8.8
class AssociationListViewModel
    extends BaseViewModel<AssociationListModel, AssociationListService> {
  AssociationListViewModel({required super.model});

  @override
  AssociationListService createService() => AssociationListService();

  /// 根据社团类别获取社团列表
  ///
  /// [id] 社团类别id
  getAssociationByTab(int id) {
    service?.getAssociationInfoByTabId(id, onDataSuccess: (data, msg) {
      var model = context.readViewModel<AssociationListViewModel>().model;
      model.associationList =
          data.map((json) => AssociationInfoBean.fromJson(json)).toList();
      notifyListeners();
    });
  }
}