import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/util/typedef_util.dart';

/// 论坛Service
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class ForumService extends BaseService {
  /// 获取所有帖子标签
  ///
  /// [onDataSuccess] 获取数据成功回调
  void getAllTabs({required OnDataSuccess<KeyList> onDataSuccess}) {
    get(UrlAssets.getAllTabs, onDataSuccess: onDataSuccess);
  }
}
