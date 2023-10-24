import 'package:csust_edu_system/ass/key_assets.dart';

/// 版本相关信息Bean类
///
/// @author zzp
/// @since 2023/10/24
/// @version v1.8.8
class VersionInfoBean {
  VersionInfoBean.fromJson(Map<String, dynamic> json)
      : apkPath = json[KeyAssets.apkPath],
        info = json[KeyAssets.info],
        form = json[KeyAssets.form],
        version = json[KeyAssets.version],
        forcedUpdating = json[KeyAssets.forcedUpdating];

  /// apk路径
  String apkPath;

  /// 版本信息
  String info;

  /// 应用类型(apk or ipa)
  String form;

  /// 版本
  String version;

  /// 是否强制更新
  bool forcedUpdating;
}
