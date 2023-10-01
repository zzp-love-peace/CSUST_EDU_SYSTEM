import 'package:csust_edu_system/ass/image_assets.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/school/jsonbean/school_notice_bean.dart';
import 'package:flutter/material.dart';

import '../../schoolnotice/page/shcool_notice_page.dart';

/// 教务通知item View
///
/// @author zzp
/// @since 2023/10/1
/// @version v1.8.8
class SchoolNoticeItemView extends StatelessWidget {
  const SchoolNoticeItemView({super.key, required this.schoolNoticeBean});

  /// 教务通知Bean类
  final SchoolNoticeBean schoolNoticeBean;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(12, 3, 12, 8),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Ink(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            onTap: () {
              context.push(SchoolNoticePage(schoolNoticeBean.ggid));
            },
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 18, 10, 18),
                      child: ClipOval(
                          child: Image.asset(ImageAssets.csustLogo,
                              width: 60, height: 60, fit: BoxFit.cover)),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 12),
                      child: Text(
                        schoolNoticeBean.title,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 3),
                  child: Text(
                    schoolNoticeBean.time.substring(0, 10),
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
