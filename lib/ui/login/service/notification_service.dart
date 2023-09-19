import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/url_assets.dart';

import '../../../utils/typedef_util.dart';

class NotificationService extends BaseService{
  ///获取通知
  ///
  /// [onDataSuccess] 获取数据成功回调
  ///
  void getNotifications({required OnDataSuccess<KeyList> onDataSuccess}){
    get(UrlAssets.getNotifications, onDataSuccess: onDataSuccess);
  }
}