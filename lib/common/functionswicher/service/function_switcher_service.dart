import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/util/typedef_util.dart';

/// 功能开关Service
///
/// @author zzp
/// @since 2023/10/8
/// @version v1.8.8
class FunctionSwitcherService extends BaseService {
  /// 获取功能开关
  ///
  /// [onDataSuccess] 获取数据成功回调
  void getFunctionSwitchers({required OnDataSuccess<KeyMap> onDataSuccess}) {
    post(UrlAssets.getFunctionSwitchers, onDataSuccess: onDataSuccess);
  }
}
