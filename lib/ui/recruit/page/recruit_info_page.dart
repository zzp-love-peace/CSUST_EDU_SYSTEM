import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:flutter/material.dart';

import '../jsonbean/recruit_bean.dart';

/// 兼职详情页
///
/// @author zzp
/// @since 2023/10/27
/// @version v1.8.8
class RecruitInfoPage extends StatelessWidget {
  const RecruitInfoPage({super.key, required this.recruitBean});

  /// 兼职信息
  final RecruitBean recruitBean;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.create(StringAssets.recruitDetail),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              recruitBean.title,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
              child: Text(
                recruitBean.content,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Text(
              '${StringAssets.workDate}：${recruitBean.workDate}',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${StringAssets.detailedTime}：${recruitBean.workTime}',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            SelectableText(
              '${StringAssets.contact}：${recruitBean.contact}',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${StringAssets.disclaimer}：${recruitBean.duty}',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
