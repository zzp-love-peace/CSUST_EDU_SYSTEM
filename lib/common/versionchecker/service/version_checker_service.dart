import 'dart:io';

import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/util/typedef_util.dart';

/// 版本检查Service
///
/// @author zzp
/// @since 2023/10/24
/// @version v1.8.8
class VersionCheckerService extends BaseService {
  /// 获取最新版本
  ///
  /// [onDataSuccess] 获取数据成功回调
  void getLastVersion({required OnDataSuccess<KeyMap> onDataSuccess}) {
    String form;
    if (Platform.isAndroid) {
      form = StringAssets.apk;
    } else if (Platform.isIOS) {
      form = StringAssets.ipa;
    } else {
      return;
    }
    var params = {KeyAssets.flag: 2, KeyAssets.form: form};
    get(UrlAssets.getLastVersion, params: params, onDataSuccess: onDataSuccess);
  }
}
