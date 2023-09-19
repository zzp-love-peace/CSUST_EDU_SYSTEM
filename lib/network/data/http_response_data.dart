import 'dart:convert';

import 'package:csust_edu_system/arch/basedata/base_json_bean.dart';
import 'package:csust_edu_system/ass/key_assets.dart';

/// 返回数据的code
///
/// 其中[T]只能为Map或List
///
/// @author zzp
/// @since 2023/9/15
/// @version v1.8.8
class HttpResponseData<T> implements BaseJsonBean {
  HttpResponseData(this.code, this.msg, this.data);

  HttpResponseData.fromJson(Map<String, dynamic> json):
        code = json[KeyAssets.code], msg = json[KeyAssets.msg], data = json[KeyAssets.data];

  HttpResponseData.fromJsonString(String jsonString): this.fromJson(jsonDecode(jsonString));

  /// 请求结果状态码（200为正常）
  int code;
  /// 信息
  String msg;
  /// 数据
  T data;

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json[KeyAssets.code] = code;
    json[KeyAssets.msg] = msg;
    json[KeyAssets.data] = data;
    return json;
  }

  @override
  String toJsonString() {
    var json = this.toJson();
    return jsonEncode(json);
  }
}