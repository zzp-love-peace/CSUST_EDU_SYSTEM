/// 所有Bean类的基类
///
/// @author zzp
/// @since 2023/9/15
/// @version v1.8.8
abstract class BaseJsonBean {

  BaseJsonBean.fromJson(Map<String, dynamic> json);

  /// 将对象转为json
  Map<String, dynamic> toJson();

  /// 将对象转为json字符串
  String toJsonString();
}