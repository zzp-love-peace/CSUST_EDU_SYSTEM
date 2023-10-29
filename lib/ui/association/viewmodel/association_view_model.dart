import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ui/association/jsonbean/association_info_bean.dart';
import 'package:csust_edu_system/ui/association/jsonbean/association_tab_bean.dart';
import 'package:csust_edu_system/ui/association/model/association_model.dart';
import 'package:csust_edu_system/ui/association/service/association_service.dart';
/// 社团ViewModel
///
/// @author bmc
/// @since 2023/10/29
/// @version v1.8.8
class AssociationViewModel
    extends BaseViewModel<AssociationModel, AssociationService> {
  AssociationViewModel({required super.model});

  @override
  AssociationService? createService() => AssociationService();

  /// 获取社团类别列表
  void getAssociationTabList() {
    service?.getAssociationTabList(
      onDataSuccess: (data, msg) {
        model.tabList = data.map((json) => AssociationTabBean.fromJson(json)).toList();
        model.associationList = data.map((json) => AssociationInfoBean.fromJson(json)).toList();
        notifyListeners();
      },
    );
  }
}
