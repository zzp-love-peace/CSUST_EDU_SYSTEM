import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:dio/dio.dart';

import '../../../ass/key_assets.dart';
import '../../../ass/url_assets.dart';
import '../../../util/typedef_util.dart';

/// 成绩Service类
///
/// @author wk
/// @since 2023/10/28
/// @version v1.8.8
class GradeService extends BaseService {
  /// 查询成绩列表
  ///
  /// [onDataSuccess] 获取数据成功回调
  /// [term] 学期
  /// [cookie] cookie
  /// [onFinish] 请求结束回调
  void queryScore(
      {required String cookie,
      required String term,
      required OnDataSuccess<KeyList> onDataSuccess,
      OnFinish? onFinish}) {
    var params = FormData.fromMap({
      KeyAssets.cookie: cookie,
      KeyAssets.xueqi: term,
    });
    post(UrlAssets.queryScore,
        params: params, onDataSuccess: onDataSuccess, onFinish: onFinish);
  }

  /// 查询成绩详情
  ///
  /// [onDataSuccess] 获取数据成功回调
  /// [cookie] cookie
  /// [gradeInfoUrl] 成绩详情Url
  /// [onFinish] 请求结束回调
  void queryScoreInfo(
      {required String cookie,
      required String gradeInfoUrl,
      required OnDataSuccess<KeyMap> onDataSuccess,
      OnFinish? onFinish}) {
    var params = FormData.fromMap({
      KeyAssets.cookie: cookie,
      KeyAssets.gradeInfoUrl: gradeInfoUrl,
    });
    post(UrlAssets.queryScoreInfo,
        params: params, onDataSuccess: onDataSuccess, onFinish: onFinish);
  }
}
