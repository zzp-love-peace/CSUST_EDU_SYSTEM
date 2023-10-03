import 'package:csust_edu_system/ass/image_assets.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/telephonecard/page/order_page.dart';
import 'package:csust_edu_system/ui/telephonecard/page/package_page.dart';
import 'package:csust_edu_system/ui/telephonecard/page/service_page.dart';
import 'package:csust_edu_system/ui/telephonecard/page/teach_page.dart';
import 'package:flutter/material.dart';

import '../../../ass/string_assets.dart';
import 'function_item_view.dart';

/// 功能BarView
///
/// @author wk
/// @since 2023/9/27
/// @version v1.8.8
class FunctionBarView extends StatelessWidget {
  const FunctionBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        // elevation: 0,
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
                  '主要功能',
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
            Row(
              children: [
                FunctionItemView(
                  label: StringAssets.packageDetail,
                  path: ImageAssets.package,
                  tapCallback: () {
                    context.push(const PackagePage());
                  },
                ),
                FunctionItemView(
                  label: StringAssets.teach,
                  path: ImageAssets.teach,
                  tapCallback: () {
                    context.push(const TeachPage());
                  },
                ),
                FunctionItemView(
                  label: StringAssets.order,
                  path: ImageAssets.order,
                  tapCallback: () {
                    context.push(const OrderPage());
                  },
                ),
                FunctionItemView(
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
