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

  void getOrderList() {
    service?.getOrderList(onDataSuccess: (data, msg) {
      List records = data[KeyAssets.records];
      if (records.isNotEmpty) {
        for (var record in records) {
          var orderBean = OrderBean.fromJson(record);
          orderBean.init();
          model.orderList.add(orderBean);
        }
      }
      notifyListeners();
    });
  }

  void deleteOrder(int id, OrderBean orderBean) {
    service?.deleteOrder(id, onDataSuccess: (data, msg) {
      StringAssets.deleteOrder.showToast();
      model.orderList.remove(orderBean);
      notifyListeners();
    }, onDataFail: (code, msg) {
      msg.showToast();
    });
  }
}
