import 'package:csust_edu_system/arch/baseservice/base_service.dart';

import '../../../ass/key_assets.dart';
import '../../../ass/url_assets.dart';
import '../../../util/typedef_util.dart';

/// 电话卡Service
///
/// @author wk
/// @since 2023/9/28
/// @version v1.8.8
class TelephoneService extends BaseService {
  /// 根据套餐，校区获取卡号
  ///
  /// [school] 校区
  /// [package] 套餐
  void getCardByKind(String school, String package,
      {required OnDataSuccess<KeyMap> onDataSuccess, OnDataFail? onDataFail}) {
    var params = {
      KeyAssets.kindName: package,
      KeyAssets.school: school,
    };
    post(UrlAssets.getCardByKind,
        params: params, onDataSuccess: onDataSuccess, onDataFail: onDataFail);
  }
}
