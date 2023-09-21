import 'dart:convert';

/// 所有Bean类的基类
///
/// @author zzp
/// @since 2023/9/15
/// @version v1.8.8
abstract class BaseJsonBean {

  /// 将对象转为json
  Map<String, dynamic> toJson();

  /// 将对象转为json字符串
  String toJsonString() {
    var json = toJson();
    return jsonEncode(json);
  }
}