import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:flutter/material.dart';

/// 服务介绍详情页
///
/// @author wk
/// @since 2023/9/27
/// @version v1.8.8
class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.create(StringAssets.serviceDetail),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text(StringAssets.service1,
                    style: TextStyle(color: Colors.black, fontSize: 16))),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text(StringAssets.service2,
                    style: TextStyle(color: Colors.black54, fontSize: 16))),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
