import 'package:csust_edu_system/ui/association/jsonbean/association_info_bean.dart';
import 'package:csust_edu_system/ui/association/page/association_info_page.dart';
import 'package:flutter/material.dart';

import '../../../common/cachedimage/view/cached_image.dart';

/// 社团列表Item View
///
/// @author bmc
/// @since 2023/10/29
/// @version v1.8.8
class AssociationItemView extends StatelessWidget {
  const AssociationItemView({super.key, required this.assInfo});

  /// 社团信息
  final AssociationInfoBean assInfo;

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AssociationInfoPage(assInfo: assInfo)));
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 15, 15),
              child: ClipOval(
                child: CachedImage(
                  size: 45,
                  fit: BoxFit.cover,
                  url: '${assInfo.icon}/webp',
                  progressWidget: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: CachedImage(
                      size: 45,
                      fit: BoxFit.cover,
                      url: assInfo.icon,
                      progressWidget: (context, url, downloadProgress) =>
                          CircularProgressIndicator(
                              value: downloadProgress.progress),
                      errorWidget: Container(
                          width: 45,
                          height: 45,
                          color: Theme.of(context).primaryColor)),
                ),
              ),
            ),
            Text(
              assInfo.name,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const Spacer(),
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
