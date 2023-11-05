import 'package:csust_edu_system/arch/baseservice/base_service.dart';

import '../../../ass/key_assets.dart';
import '../../../ass/url_assets.dart';
import '../../../util/typedef_util.dart';

/// 社团列表Service
///
/// @author bmc
/// @since 2023/11/05
/// @version v1.8.8
class AssociationListService extends BaseService {
  /// 根据社团类别获取社团列表
  ///
  /// [id] 社团类别id
  /// [OnDataSuccess] 获取数据成功回调
  void getAssociationInfoByTabId(int id,
      {required OnDataSuccess<KeyList> onDataSuccess}) {
    get(UrlAssets.getAssociationInfoByTabId,
        params: {KeyAssets.id: id}, onDataSuccess: onDataSuccess);
  }
}
