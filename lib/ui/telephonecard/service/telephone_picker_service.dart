import 'package:csust_edu_system/arch/baseservice/base_service.dart';

import '../../../ass/key_assets.dart';
import '../../../ass/url_assets.dart';
import '../../../util/typedef_util.dart';

class TelephonePickerService extends BaseService {
  /// 根据套餐，校区获取卡号
  ///
  /// [school] 校区
  /// [package] 套餐
  /// [onDataSuccess] 获取数据成功回调
  void getCardByKind(String school, String package,
      {required OnDataSuccess<KeyMap> onDataSuccess}) {
    var params = {
      KeyAssets.kindName: package,
      KeyAssets.school: school,
    };
    post(UrlAssets.getCardByKind, params: params, onDataSuccess: onDataSuccess);
  }
}
