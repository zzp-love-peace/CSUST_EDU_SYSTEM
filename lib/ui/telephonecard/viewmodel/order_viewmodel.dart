import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/telephonecard/model/order_model.dart';
import 'package:csust_edu_system/ui/telephonecard/service/order_service.dart';

import '../../../ass/key_assets.dart';
import '../jsonbean/order_bean.dart';

/// 电话卡订单ViewModel类
///
/// @author wk
/// @since 2023/10/2
/// @version v1.8.8
class OrderViewModel extends BaseViewModel<OrderModel, OrderService> {
  OrderViewModel({required super.model});

  @override
  OrderService? createService() => OrderService();
  /// 获取订单列表
  void getOrderList() {
    service?.getOrderList(onDataSuccess: (data, msg) {
      List records = data[KeyAssets.records];
      model.orderList = records.map((json) {
        OrderBean orderBean = OrderBean.fromJson(json);
        orderBean.init();
        return orderBean;
      }).toList();
      notifyListeners();
    });
  }

  /// 删除订单
  ///
  /// [id] 订单id
  /// [orderBean] 具体订单
  void deleteOrder(int id, OrderBean orderBean) {
    service?.deleteOrder(
      id,
      onDataSuccess: (data, msg) {
        StringAssets.deleteOrderSuccess.showToast();
        model.orderList.remove(orderBean);
        notifyListeners();
      },
    );
  }
}
