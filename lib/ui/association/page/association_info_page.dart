import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ui/association/jsonbean/association_info_bean.dart';
import 'package:flutter/material.dart';

import '../../../ass/string_assets.dart';
import '../../../common/cachedimage/view/cached_image.dart';

/// 社团信息页
///
/// @author bmc
/// @since 2023/10/29
/// @version v1.8.8
class AssociationInfoPage extends StatelessWidget {
  const AssociationInfoPage({super.key, required this.assInfo});

  /// 社团信息
  final AssociationInfoBean assInfo;

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
      builder: (ctx, viewModel, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            foregroundColor: Colors.white,
            title: const Text(
              StringAssets.associationInfo,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ClipOval(
                    child: CachedImage(
                      size: 80,
                      fit: BoxFit.cover,
                      url: '${assInfo.icon}/webp',
                      progressWidget: (context, url, downloadProgress) =>
                          CircularProgressIndicator(
                              value: downloadProgress.progress),
                      errorWidget: CachedImage(
                          size: 80,
                          fit: BoxFit.cover,
                          url: assInfo.icon,
                          progressWidget: (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                          errorWidget: Container(
                              width: 80,
                              height: 80,
                              color: Theme.of(context).primaryColor)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    assInfo.name,
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
                    child: Text(
                      assInfo.introduce,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  Text(StringAssets.publicNum + assInfo.publicNum,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(StringAssets.officialQQ + assInfo.qq,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black)),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(StringAssets.sourceOfMaterial,
                      style: TextStyle(fontSize: 12, color: Colors.blueGrey)),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
