import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/util/typedef_util.dart';
import '../../../ass/key_assets.dart';
import '../../../ass/url_assets.dart';
/// 社团Service
///
/// @author bmc
/// @since 2023/10/29
/// @version v1.8.8
class AssociationService extends BaseService {

  /// 获取社团类别列表
  ///
  /// [OnDataSuccess] 获取数据成功回调
  void getAssociationTabList({required OnDataSuccess<KeyList> onDataSuccess}) {
    get(UrlAssets.getAssociationTabList, onDataSuccess: onDataSuccess);
  }

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
