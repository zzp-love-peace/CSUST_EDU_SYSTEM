import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/telephonecard/jsonbean/order_bean.dart';
import 'package:csust_edu_system/ui/telephonecard/viewmodel/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import '../../../common/dialog/select_dialog.dart';

/// 订单列表Item类
///
/// @author wk
/// @since 2023/10/3
/// @version v1.8.8
class OrderListItemView extends StatelessWidget {
  const OrderListItemView({super.key, required this.orderBean});

  /// 订单数据
  final OrderBean orderBean;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Stack(alignment: Alignment.bottomRight, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 30, 5),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    SmartDialog.show(
                      builder: (_) => _orderDialog(orderBean),
                    );
                  },
                  child: Row(children: [
                    Icon(
                      Icons.arrow_right,
                      color: Colors.black.withOpacity(0.7),
                      size: 36,
                    ),
                    const Text(
                      StringAssets.bookCardNumber,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        child: Text(
                      orderBean.number,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    )),
                  ]),
                )),
                IconButton(
                    onPressed: () {
                      SelectDialog(
                          title: StringAssets.tips,
                          subTitle: StringAssets.isSureDeleteOrder,
                          callback: () {
                            var orderViewModel = context.read<OrderViewModel>();
                            orderViewModel.deleteOrder(orderBean.id, orderBean);
                          }).showDialog();
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 3),
            child: Text(
              orderBean.createTime.substring(0, 10),
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          )
        ]));
  }

  /// 获取自定义的dialog
  ///
  /// [orderBean] 具体订单
  Widget _orderDialog(OrderBean orderBean) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 450,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _row(StringAssets.schoolArea, orderBean.school),
                _row(StringAssets.package, orderBean.package),
                _row(StringAssets.bookCardNumber, orderBean.number),
                _row(StringAssets.cardReceivingTime, orderBean.freeTime),
                _row(StringAssets.name, orderBean.name),
                _row(StringAssets.contactPhoneNumber, orderBean.mobile),
                _row(StringAssets.address, orderBean.address),
                _row(StringAssets.submitOrderTime, orderBean.createTime),
              ],
            ),
          )),
    );
  }

  /// 获取带Text的Row
  ///
  /// [title] 标题
  /// [value] 值
  Widget _row(String title, String value) {
    return Row(
      children: [Text(title), const SizedBox(width: 10), Text(value)],
    );
  }
}
