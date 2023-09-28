import 'package:flutter/material.dart';

import '../../../ass/string_assets.dart';
import '../../../common/appbar/common_app_bar.dart';

/// 套餐详情页
///
/// @author wk
/// @since 2023/9/27
/// @version v1.8.8
class PackagePage extends StatelessWidget {
  const PackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar.create(StringAssets.packageDetail),
        body: ListView(
          children: const [
            Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text(StringAssets.package1,
                    style: TextStyle(color: Colors.black, fontSize: 16))),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(StringAssets.package2,
                    style: TextStyle(color: Colors.black, fontSize: 16))),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(StringAssets.equity1,
                    style: TextStyle(color: Colors.black, fontSize: 16))),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(StringAssets.equity2,
                    style: TextStyle(color: Colors.black, fontSize: 16))),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(StringAssets.equity3,
                    style: TextStyle(color: Colors.black54, fontSize: 16))),
            SizedBox(
              height: 50,
            ),
          ],
        ));
  }
}
