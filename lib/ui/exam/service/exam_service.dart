import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:dio/dio.dart';

import '../../../ass/key_assets.dart';
import '../../../ass/url_assets.dart';
import '../../../util/typedef_util.dart';

/// 考试Service
///
/// @author wk
/// @since 2023/11/4
/// @version v1.8.8
class ExamService extends BaseService {
  ///  获取考试列表
  ///
  /// [onDataSuccess] 获取数据成功回调
  /// [term] 学期
  /// [cookie] cookie
  /// [onFinish] 请求结束回调
  void queryExam(
      {required String cookie,
      required String term,
      required OnDataSuccess<KeyList> onDataSuccess,
      OnFinish? onFinish}) {
    var params = FormData.fromMap({
      KeyAssets.cookie: cookie,
      KeyAssets.xueqi: term,
    });
    post(UrlAssets.queryExam,
        params: params, onDataSuccess: onDataSuccess, onFinish: onFinish);
  }
}
