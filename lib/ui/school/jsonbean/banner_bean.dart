import 'package:csust_edu_system/ass/key_assets.dart';

/// 轮播图Bean类
///
/// @author zzp
/// @since 2023/10/1
/// @version v1.8.8
class BannerBean {
  BannerBean.fromJson(Map<String, dynamic> json)
      : url = json[KeyAssets.url],
        detailUrl = json[KeyAssets.detailUrl];

  /// 轮播图url
  String url;

  /// 点开后的详情图片url
  String detailUrl;
}
