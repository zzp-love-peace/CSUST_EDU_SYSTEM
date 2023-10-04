import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';

/// 电话卡订单Bean类
///
/// @author wk
/// @since 2023/10/3
/// @version v1.8.8
class OrderBean {
  OrderBean.fromJson(Map<String, dynamic> json)
      : id = json[KeyAssets.order][KeyAssets.id],
        freeTime = json[KeyAssets.order][KeyAssets.freeDate],
        name = json[KeyAssets.order][KeyAssets.name],
        mobile = json[KeyAssets.order][KeyAssets.mobile],
        address = json[KeyAssets.order][KeyAssets.dormitory],
        createTime = json[KeyAssets.createTime],
        number = json[KeyAssets.card][KeyAssets.mobile],
        package = json[KeyAssets.card][KeyAssets.kindName],
        school = json[KeyAssets.card][KeyAssets.school];

  /// 订单id
  int id;

  /// 卡号
  String number;

  /// 套餐
  String package;

  /// 校区
  String school;

  /// 收卡时间
  String freeTime;

  /// 姓名
  String name;

  /// 联系电话
  String mobile;

  /// 详细地址
  String address;

  /// 创建订单时间
  String createTime;

  @override
  String toString() {
    return 'id:$id number:$number package:$package school:$school freeTime:$freeTime name:$name mobile:$mobile address:$address createTme:$createTime';
  }

  /// 修改套餐，订单时间格式
  void init() {
    if (package == '59') {
      package = StringAssets.package59;
    }
    if (package == '28') {
      package = StringAssets.package28;
    }
    if (freeTime == StringAssets.time) {
      freeTime = '';
    }
    if (createTime.isNotEmpty) {
      createTime = createTime.replaceAll('T', ' - ');
      createTime = createTime.substring(0, 21);
    }
  }
}
