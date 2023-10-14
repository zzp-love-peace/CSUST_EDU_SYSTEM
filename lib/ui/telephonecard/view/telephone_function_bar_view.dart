import 'package:csust_edu_system/ass/image_assets.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/telephonecard/page/order_page.dart';
import 'package:csust_edu_system/ui/telephonecard/page/package_page.dart';
import 'package:csust_edu_system/ui/telephonecard/page/service_page.dart';
import 'package:csust_edu_system/ui/telephonecard/page/teach_page.dart';
import 'package:flutter/material.dart';

import '../../../ass/string_assets.dart';
import 'telephone_function_item_view.dart';

/// 功能BarView
///
/// @author wk
/// @since 2023/9/27
/// @version v1.8.8
class TelephoneFunctionBarView extends StatelessWidget {
  const TelephoneFunctionBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  StringAssets.mainFunction,
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            Row(
              children: [
                TelephoneFunctionItemView(
                  label: StringAssets.packageDetail,
                  path: ImageAssets.package,
                  tapCallback: () {
                    context.push(const PackagePage());
                  },
                ),
                TelephoneFunctionItemView(
                  label: StringAssets.tutorialView,
                  path: ImageAssets.teach,
                  tapCallback: () {
                    context.push(const TeachPage());
                  },
                ),
                TelephoneFunctionItemView(
                  label: StringAssets.orderSearch,
                  path: ImageAssets.order,
                  tapCallback: () {
                    context.push(const OrderPage());
                  },
                ),
                TelephoneFunctionItemView(
                  label: StringAssets.serviceDetail,
                  path: ImageAssets.service,
                  tapCallback: () {
                    context.push(const ServicePage());
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
