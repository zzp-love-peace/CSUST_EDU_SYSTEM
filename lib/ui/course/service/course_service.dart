import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/util/typedef_util.dart';
import 'package:dio/dio.dart';

import '../../../ass/url_assets.dart';

/// 课程表Service
///
/// @author zzp
/// @since 2023/9/20
/// @version v1.8.8
class CourseService extends BaseService {
  /// 获取某一周课程表
  ///
  /// [cookie] cookie
  /// [term] 学期
  /// [weekNum] 周数
  /// [onDataSuccess] 获取数据成功回调
  /// [onFinish] 请求结束回调
  void getWeekCourse(
      {required String cookie,
      required String term,
      required int weekNum,
      required OnDataSuccess onDataSuccess,
      OnFinish? onFinish}) {
    post(UrlAssets.getWeekCourse,
        params: FormData.fromMap({
          KeyAssets.cookie: cookie,
          KeyAssets.xueqi: term,
          KeyAssets.zc: weekNum.toString()
        }),
        onDataSuccess: onDataSuccess,
        onFinish: onFinish);
  }
}
