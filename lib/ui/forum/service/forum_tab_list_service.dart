import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/util/typedef_util.dart';

/// 标签帖子列表Service
///
/// @author zzp
/// @since 2023/10/19
/// @version v1.8.8
class ForumTabListService extends BaseService {
  /// 根据标签获取帖子列表
  ///
  /// [tabId] 标签id
  /// [page] 页数
  /// [row] 单页帖子数
  /// [onDataSuccess] 获取数据成功回调
  void getForumListByTabId(
      {required int tabId,
      required int page,
      required int rows,
      required OnDataSuccess<KeyMap> onDataSuccess}) {
    var params = {
      KeyAssets.themeId: tabId,
      KeyAssets.page: page,
      KeyAssets.rows: rows
    };
    post(UrlAssets.getForumListByTabId,
        params: params, onDataSuccess: onDataSuccess);
  }
}
