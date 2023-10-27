import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/recruit/jsonbean/recruit_bean.dart';
import 'package:csust_edu_system/ui/recruit/page/recruit_info_page.dart';
import 'package:flutter/material.dart';

/// 兼职item View
///
/// @author zzp
/// @since 2023/10/27
/// @version v1.8.8
class RecruitItemView extends StatelessWidget {
  const RecruitItemView({super.key, required this.recruitBean});

  /// 兼职信息
  final RecruitBean recruitBean;

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          context.push(RecruitInfoPage(recruitBean: recruitBean));
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 15, 20),
              child: Text(
                recruitBean.title,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Text(
                recruitBean.content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            const Icon(
              Icons.arrow_right,
              color: Colors.black,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
