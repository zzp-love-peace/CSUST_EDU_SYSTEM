import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/telephonecard/jsonbean/order_bean.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../common/dialog/select_dialog.dart';

/// 订单列表Item类
///
/// @author wk
/// @since 2023/10/3
/// @version v1.8.8
class OrderListItemView extends StatelessWidget {
  const OrderListItemView(
      {super.key, required this.orderBean, required this.deleteOrder});

  final OrderBean orderBean;
  final void Function(int id, OrderBean orderBean) deleteOrder;

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
                    SmartDialog.compatible.show(
                        widget: _orderDialog(orderBean), isLoadingTemp: false);
                  },
                  child: Row(children: [
                    Icon(
                      Icons.arrow_right,
                      color: Colors.black.withOpacity(0.7),
                      size: 36,
                    ),
                    const Text(
                      StringAssets.bookNumber,
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
                      SmartDialog.compatible.show(
                          widget: SelectDialog(
                              title: '提示',
                              subTitle: '您确定要删除该订单吗？',
                              callback: () {
                                deleteOrder(orderBean.id, orderBean);
                              }),
                          clickBgDismissTemp: false);
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
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Text('校区:'),
                    const SizedBox(width: 10),
                    Text(orderBean.school)
                  ],
                ),
                Row(
                  children: [
                    const Text('套餐:'),
                    const SizedBox(width: 10),
                    Text(orderBean.package)
                  ],
                ),
                Row(
                  children: [
                    const Text('预订卡号:'),
                    const SizedBox(width: 10),
                    Text(orderBean.number)
                  ],
                ),
                Row(
                  children: [
                    const Text('收卡时间:'),
                    const SizedBox(width: 10),
                    Text(orderBean.freeTime)
                  ],
                ),
                Row(
                  children: [
                    const Text('姓名:'),
                    const SizedBox(width: 10),
                    Text(orderBean.name)
                  ],
                ),
                Row(
                  children: [
                    const Text('联系电话'),
                    const SizedBox(width: 10),
                    Text(orderBean.mobile)
                  ],
                ),
                Row(
                  children: [
                    const Text('详细地址:'),
                    const SizedBox(width: 10),
                    Text(orderBean.address)
                  ],
                ),
                Row(
                  children: [
                    const Text('提交订单时间:'),
                    const SizedBox(width: 10),
                    Text(orderBean.createTime)
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
