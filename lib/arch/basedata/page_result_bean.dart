import '../../data/page_result_code.dart';

/// 页面返回Bean类
///
/// @author zzp
/// @since 2023/9/24
/// @version v1.8.8
class PageResultBean<T> {
  PageResultBean(this.resultCode, this.resultData);

  /// 返回状态码
  PageResultCode resultCode;

  /// 返回具体数据
  T resultData;
}
