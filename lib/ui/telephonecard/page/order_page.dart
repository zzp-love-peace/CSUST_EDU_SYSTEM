import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/ui/telephonecard/model/order_model.dart';
import 'package:csust_edu_system/ui/telephonecard/view/order_list_item_view.dart';
import 'package:csust_edu_system/ui/telephonecard/viewmodel/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 电话卡订单页
///
/// @author wk
/// @since 2023/10/2
/// @version v1.8.8
class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => OrderViewModel(model: OrderModel()))
      ],
      child: const OrderHome(),
    );
  }
}

class OrderHome extends StatelessWidget {
  const OrderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.create(StringAssets.order),
      body: ConsumerView<OrderViewModel>(
        onInit: (viewModel) {
          viewModel.getOrderList();
        },
        builder: (context, viewModel, _) {
          return ListView.builder(
              itemCount: viewModel.model.orderList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return OrderListItemView(
                  orderBean: viewModel.model.orderList[index],
                  deleteOrder: viewModel.deleteOrder,
                );
              });
        },
      ),
    );
  }
}
