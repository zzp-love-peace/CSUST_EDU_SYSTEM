import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/util/typedef_util.dart';

/// 我的发帖Service
///
/// @author zzp
/// @since 2023/10/21
/// @version v1.8.8
class MyForumService extends BaseService {
  /// 获取我的发帖列表
  ///
  /// [onDataSuccess]
  void getMyForumList({required OnDataSuccess<KeyList> onDataSuccess}) {
    get(UrlAssets.getMyForumList, onDataSuccess: onDataSuccess);
  }
}
