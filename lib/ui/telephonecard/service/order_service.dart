import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/url_assets.dart';

import '../../../ass/key_assets.dart';
import '../../../util/typedef_util.dart';

/// 电话卡订单Service类
///
/// @author wk
/// @since 2023/10/2
/// @version v1.8.8
class OrderService extends BaseService {
  ///用户获取订单列表
  void getOrderList({required OnDataSuccess<KeyMap> onDataSuccess}) {
    post(UrlAssets.getOrderList, onDataSuccess: onDataSuccess);
  }

  ///用户删除订单
  ///
  /// [id]订单id
  void deleteOrder(int id, {required OnDataSuccess<KeyMap?> onDataSuccess}) {
    var params = {
      KeyAssets.id: id,
    };
    post(UrlAssets.deleteOrder, params: params, onDataSuccess: onDataSuccess);
  }
}
