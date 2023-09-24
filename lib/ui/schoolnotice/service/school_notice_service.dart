import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:dio/dio.dart';

import '../../../ass/key_assets.dart';
import '../../../util/typedef_util.dart';

/// 学校通知Service
///
/// @author wk
/// @since 2023/9/22
/// @version v1.8.8
class SchoolNoticeService extends BaseService {
  ///获取学校通知详情
  ///
  /// [cookie] cookie字符串
  /// [ggid] 学校通知id
  /// [onDataSuccess] 获取数据成功回调
  /// [onDataFail] 获取数据失败回调
  void getNoticeDetail(String cookie, String ggid,
      {required OnDataSuccess<KeyMap> onDataSuccess, OnDataFail? onDataFail}) {
    var params = FormData.fromMap({
      KeyAssets.cookie: cookie,
      KeyAssets.ggid: ggid,
    });
    post(UrlAssets.getNoticeDetail,
        params: params, onDataSuccess: onDataSuccess, onDataFail: onDataFail);
  }
}
