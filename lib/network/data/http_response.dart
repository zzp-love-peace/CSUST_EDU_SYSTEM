import 'package:csust_edu_system/network/data/response_status.dart';

/// 请求结果返回值类
///
/// @author zzp
/// @since 2023/9/14
/// @version v1.8.8
class HttpResponse<T> {
  HttpResponse(this.status, this.data);
  /// 请求状态
  ResponseStatus status;
  /// 数据
  T data;

  @override
  String toString() {
    return '{status:$status, data:$data}';
  }
}