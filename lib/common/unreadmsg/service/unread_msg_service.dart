import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/util/typedef_util.dart';

/// 未读消息Service
/// @author zzp
/// @since 2023/9/19
/// @version v1.8.8
class UnreadMsgService extends BaseService {

  /// 获取未读消息
  ///
  /// [onDataSuccess] 获取数据成功回调
  void getUnreadMsg({required OnDataSuccess<KeyList> onDataSuccess}) {
    get(UrlAssets.getUnreadMsg, onDataSuccess: onDataSuccess);
  }
}