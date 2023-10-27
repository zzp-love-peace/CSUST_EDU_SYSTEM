import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/util/typedef_util.dart';

/// 兼职Service
///
/// @author zzp
/// @since 2023/10/27
/// @version v1.8.8
class RecruitService extends BaseService {
  /// 获取所有兼职信息
  ///
  /// [onDataSuccess] 获取数据成功回调
  void getAllRecruitInfo({required OnDataSuccess<KeyList> onDataSuccess}) {
    get(UrlAssets.getAllRecruitInfo, onDataSuccess: onDataSuccess);
  }

  /// 通过标题获取兼职信息
  ///
  /// [title] 标题
  /// [onDataSuccess] 获取数据成功回调
  void getRecruitInfoByTitle(
      {required String title, required OnDataSuccess<KeyList> onDataSuccess}) {
    get(UrlAssets.getRecruitInfoByTitle,
        params: {KeyAssets.name: title}, onDataSuccess: onDataSuccess);
  }
}
