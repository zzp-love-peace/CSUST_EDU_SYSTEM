import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/association/jsonbean/association_info_bean.dart';
import 'package:flutter/material.dart';

import '../../../ass/string_assets.dart';
import '../../../common/appbar/common_app_bar.dart';
import '../../../common/cachedimage/data/cached_image_type.dart';
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
    return Scaffold(
      appBar: CommonAppBar.create(
        StringAssets.associationInfo,
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
                  type: CachedImageType.webp,
                  url: assInfo.icon.httpsToHttp(),
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
                  style: const TextStyle(fontSize: 14, color: Colors.black)),
              const SizedBox(
                height: 10,
              ),
              Text(StringAssets.officialQQ + assInfo.qq,
                  style: const TextStyle(fontSize: 14, color: Colors.black)),
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
  }
}
