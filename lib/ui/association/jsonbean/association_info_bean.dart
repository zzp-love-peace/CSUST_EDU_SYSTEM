import 'dart:convert';
import 'package:csust_edu_system/ass/key_assets.dart';

/// 社团信息Bean类
///
/// @author bmc
/// @since 2023/10/29
/// @version v1.8.8
class AssociationInfoBean {
  AssociationInfoBean(
      this.id, this.name, this.icon, this.introduce, this.qq, this.publicNum);

  AssociationInfoBean.fromJsonString(String jsonString)
      : this.fromJson(jsonDecode(jsonString));

  AssociationInfoBean.fromJson(Map<String, dynamic> json) :
    id = json[KeyAssets.id],
    name = json[KeyAssets.name],
    icon = json[KeyAssets.icon],
    introduce = json[KeyAssets.introduce],
    qq = json[KeyAssets.qq],
    publicNum = json[KeyAssets.publicNum];


  /// 社团id
  int id;

  /// 社团名
  String name;

  /// 社团团徽
  String icon;

  /// 社团介绍
  String introduce;

  // 社团官q
  String qq;

  /// 社团公众号
  String publicNum;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssociationInfoBean &&
          id == other.id &&
          name == other.name &&
          icon == other.icon &&
          introduce == other.introduce &&
          qq == other.qq &&
          publicNum == other.publicNum;

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + name.hashCode;
    result = 37 * result + icon.hashCode;
    result = 37 * result + introduce.hashCode;
    result = 37 * result + qq.hashCode;
    result = 37 * result + publicNum.hashCode;
    return result;
  }
}
