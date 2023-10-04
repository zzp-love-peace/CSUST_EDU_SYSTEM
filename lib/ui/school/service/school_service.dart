import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/util/typedef_util.dart';
import 'package:dio/dio.dart';

/// 校园Service
///
/// @author zzp
/// @since 2023/10/1
/// @version v1.8.8
class SchoolService extends BaseService {
  /// 获取教务通知list
  ///
  /// [cookie] cookie
  /// [onDataSuccess] 获取数据成功回调
  void getNoticeList(
      {required String cookie, required OnDataSuccess<KeyList> onDataSuccess}) {
    var params = FormData.fromMap({KeyAssets.cookie: cookie});
    post(UrlAssets.getNoticeList, params: params, onDataSuccess: onDataSuccess);
  }

  /// 获取轮播图图片
  ///
  /// [onDataSuccess] 获取数据成功回调
  void getBannerImg({required OnDataSuccess<KeyList> onDataSuccess}) {
    get(UrlAssets.getBannerImg, onDataSuccess: onDataSuccess);
  }
}
