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
            _paddingText(
                text: StringAssets.package59DetailIntroduce, paddingTop: 10),
            _paddingText(
                text: StringAssets.package28DetailIntroduce, paddingTop: 20),
            _paddingText(text: StringAssets.equity1, paddingTop: 20),
            _paddingText(text: StringAssets.equity2, paddingTop: 20),
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
  /// [text] text的值
  /// [paddingTop] padding的top高度
  Widget _paddingText({required String text, required double paddingTop}) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, paddingTop, 20, 0),
        child: Text(text,
            style: const TextStyle(color: Colors.black, fontSize: 16)));
  }
}
