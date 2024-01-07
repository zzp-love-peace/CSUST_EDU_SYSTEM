import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:dio/dio.dart';

import '../../../ass/key_assets.dart';
import '../../../ass/url_assets.dart';
import '../../../util/typedef_util.dart';

/// 个人资料service
/// @author wk
/// @since 2023/11/26
/// @version v1.8.8
class StuInfoService extends BaseService {
  /// 刷新个人资料
  ///
  /// [onDataSuccess] 获取数据成功回调
  /// [cookie] cookie
  void refreshStuInfo(
      {required String cookie, required OnDataSuccess<KeyMap> onDataSuccess}) {
    var params = FormData.fromMap({
      KeyAssets.cookie: cookie,
    });
    post(UrlAssets.refreshStuInfo,
        params: params, onDataSuccess: onDataSuccess);
  }

  /// 设置个人资料
  ///
  /// [onDataSuccess] 获取数据成功回调
  /// [userName] 昵称
  /// [sex] 性别
  void setStuInfo(
      {required String userName,
      required bool sex,
      required OnDataSuccess<KeyMap?> onDataSuccess}) {
    var params = FormData.fromMap({
      KeyAssets.username: userName,
      KeyAssets.sex: sex,
    });
    post(UrlAssets.setStuInfo, params: params, onDataSuccess: onDataSuccess);
  }

  /// 设置头像
  ///
  /// [onDataSuccess] 获取数据成功回调
  /// [imgPath] 图片路径
  Future<void> setHeadImg(
      {required String imgPath,
      required OnDataSuccess<String> onDataSuccess}) async {
    var params = FormData.fromMap(
        {KeyAssets.img: await MultipartFile.fromFile(imgPath)});
    post(UrlAssets.setHeadImg, params: params, onDataSuccess: onDataSuccess);
  }

  /// 恢复默认头像
  ///
  /// [onDataSuccess] 获取数据成功回调
  /// [cookie] cookie
  void restoreHeadImg(
      {required String cookie, required OnDataSuccess<String> onDataSuccess}) {
    var params = FormData.fromMap({
      KeyAssets.cookie: cookie,
    });
    post(UrlAssets.restoreHeadImg,
        params: params, onDataSuccess: onDataSuccess);
  }
}
