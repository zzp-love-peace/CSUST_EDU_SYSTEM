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
          children: [
            _paddingText(StringAssets.package59DetailIntroduce, 10),
            _paddingText(StringAssets.package28DetailIntroduce, 20),
            _paddingText(StringAssets.equity1, 20),
            _paddingText(StringAssets.equity2, 20),
            const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(StringAssets.equity3,
                    style: TextStyle(color: Colors.black54, fontSize: 16))),
            const SizedBox(
              height: 50,
            ),
          ],
        ));
  }

  /// 获取带Padding的Text
  ///
  /// [value]text的值
  /// [top]padding的top高度
  Widget _paddingText(String value, double top) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, top, 20, 0),
        child: Text(value,
            style: const TextStyle(color: Colors.black, fontSize: 16)));
  }
}
