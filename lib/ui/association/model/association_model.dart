import 'package:csust_edu_system/ui/association/jsonbean/association_tab_bean.dart';
import '../jsonbean/association_info_bean.dart';

/// 社团页 Model
///
/// @author bmc
/// @since 2023/10/29
/// @version v1.8.8
class AssociationModel {

  /// 社团类别列表
  List<AssociationTabBean> tabList = [];

  /// 社团列表
  List<AssociationInfoBean> associationList = [];
}