import 'package:csust_edu_system/arch/baseservice/base_service.dart';

import '../../../ass/url_assets.dart';
import '../../../util/typedef_util.dart';

/// 我的收藏Service
///
/// @author zzp
/// @since 2023/10/21
/// @version v1.8.8
class MyCollectService extends BaseService {
  /// 获取我的收藏列表
  ///
  /// [onDataSuccess]
  void getMyCollectList({required OnDataSuccess<KeyList> onDataSuccess}) {
    get(UrlAssets.getMyCollectList, onDataSuccess: onDataSuccess);
  }
}
