import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/util/typedef_util.dart';

/// 我的Service
///
/// @author zzp
/// @since 2024/2/21
/// @version v1.8.8
class MineService extends BaseService {

  /// 获取交流群号
  ///
  /// [onDataSuccess] 获取数据成功回调
  void getCommunicationGroupID({required OnDataSuccess<String> onDataSuccess}) {
    get(UrlAssets.getCommunicationGroupID, onDataSuccess: onDataSuccess);
  }
}