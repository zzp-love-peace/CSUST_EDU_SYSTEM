import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ass/url_assets.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/network/http_helper.dart';
import 'package:csust_edu_system/util/typedef_util.dart';
import 'package:dio/dio.dart';

import '../../../network/data/response_status.dart';

/// 查电费Service
///
/// @author zzp
/// @since 2023/10/13
/// @version v1.8.8
class ElectricityService extends BaseService {
  /// 查询电费
  ///
  /// [jsonData] json数据
  /// [onDataSuccess] 获取数据成功回调
  void queryElectricity(String jsonData,
      {required OnDataSuccess onDataSuccess}) {
    HttpHelper()
        .post(
            UrlAssets.queryElectricity,
            {
              KeyAssets.jsondata: jsonData,
              KeyAssets.funname: StringAssets.queryElectricityRoomInfoValue,
              KeyAssets.json: true
            },
            contentType: Headers.formUrlEncodedContentType)
        .then(
      (value) {
        if (value.status == ResponseStatus.success) {
          onDataSuccess.call(value.data, StringAssets.emptyStr);
        } else {
          StringAssets.queryFailWithError.showToast();
        }
      },
    );
  }
}
