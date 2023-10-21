import 'package:csust_edu_system/ass/key_assets.dart';

/// 帖子标签Bean类
///
/// @author zzp
/// @since 2023/10/19
/// @version v1.8.8
class ForumTabBean {
  ForumTabBean.fromJson(Map<String, dynamic> json)
      : tabId = int.parse(json[KeyAssets.id].toString()),
        tabName = json[KeyAssets.themeName];

  /// 标签id
  int tabId;

  /// 标签名
  String tabName;
}
