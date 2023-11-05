import 'package:csust_edu_system/ass/key_assets.dart';

/// 社团类别Bean类
///
/// @author bmc
/// @since 2023/10/29
/// @version v1.8.8
class AssociationTabBean {
  AssociationTabBean.fromJson(Map<String, dynamic> json)
      : categoryName = json[KeyAssets.categoryName],
        id = json[KeyAssets.id];

  /// 社团类别名
  String categoryName;

  /// 类别id
  int id;
}