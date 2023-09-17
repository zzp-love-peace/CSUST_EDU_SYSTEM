import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class EduSystemManager {
  static final EduSystemManager _instance = EduSystemManager._internal();

  static const _baseUrl = 'http://xk.csust.edu.cn';

  static final RegExp _JW_JSESSIONID_Patten = RegExp('^JSESSIONID=.*');

  Dio? _dio;

  factory EduSystemManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  EduSystemManager._internal() {
    _dio ??= Dio(BaseOptions(baseUrl: _baseUrl, connectTimeout: const Duration(microseconds: 8000)));
  }

  static EduSystemManager getInstance() => _instance;

  Future _get(String path, {params, headers}) async {
    Response? response;
    try {
      response = await _dio?.get(path,
          queryParameters: params, options: Options(headers: headers));
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return {};
    } on TimeoutException {
      return {};
    }
    if (response?.data is DioError) {
      return {};
    }
    // print(response?.data);
    return response?.data;
  }

  Future<Response?> _getResponse(String path, {params, headers}) async {
    Response? response;
    try {
      response = await _dio?.get(path,
          queryParameters: params, options: Options(headers: headers));
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return null;
    } on TimeoutException {
      return null;
    }
    if (response?.data is DioError) {
      return null;
    }
    // print(response?.data);
    return response;
  }

  Future _post(String path, {params, headers, contentType}) async {
    Response? response;
    try {
      response = await _dio?.post(path,
          data: params,
          options: Options(headers: headers, contentType: contentType));
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return {};
    } on TimeoutException {
      return {};
    }
    if (response?.data is DioError) {
      return {};
    }
    return response?.data;
  }

  Future<Response?> _postResponse(String path,
      {params, headers, contentType}) async {
    Response? response;
    try {
      response = await _dio?.post(path,
          data: params,
          options: Options(headers: headers, contentType: contentType));
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return null;
    } on TimeoutException {
      return null;
    }
    if (response?.data is DioError) {
      return null;
    }
    print(response?.statusCode);
    return response;
  }

  Future<List<String>> _getJwCode() async {
    var response = await _getResponse('/Logon.do?method=logon&flag=sess');
    String? header = response!.headers.value('Set-Cookie');
    List<String>? split = header?.split(',');
    List<String> result = ['', ''];
    for (var s in split!) {
      if (s.contains(_JW_JSESSIONID_Patten)) {
        result[0] = s.split('=')[1];
      }
    }
    result[1] = response.data.toString();
    print("result==>$result");
    return result;
  }

  String _encodePsd(String username, String password, String dataStr) {
    List<String> splitCode = dataStr.split("#");
    String sCode = splitCode[0];
    String sxh = splitCode[1];
    String code = username + "%%%" + password;
    String encode = "";
    for (int i = 0; i < code.length; i++) {
      if (i < 20) {
        int theIndex = int.parse(sxh.substring(i, i + 1));
        encode = encode + code[i] + sCode.substring(0, theIndex);
        sCode = sCode.substring(theIndex);
      } else {
        encode = encode + code.substring(i);
        i = code.length;
      }
    }
    return encode;
  }

  Future<String?> getHeaderFromJW(String stuNum, String password) async {

    var jwCode = await _getJwCode();
    String encoded = _encodePsd(stuNum, password, jwCode[1]);

    var response = await _postResponse(
        '/Logon.do?method=logon',
        // '/jsxsd/xk/LoginToXk',
        headers: {
          "Cookie": "JSESSIONID=" + jwCode[0],
          "Host": "xk.csust.edu.cn",
          "Origin": "http://xk.csust.edu.cn",
          "Referer": "http://xk.csust.edu.cn/"
          // "Referer": "http://xk.csust.edu.cn/jsxsd/",
        },
        params: {
          "userAccount": stuNum,
          "userPassword": password,
          "encoded": encoded
        }, contentType: Headers.formUrlEncodedContentType);

    print("headers==>\n${response?.headers}");

    var updateCookieUrl = response?.headers.value("Location");
    print("updateCookieUrl==>$updateCookieUrl");
    if  (updateCookieUrl == null) {
      return null;
    }
    var updateCookieResponse = await _getResponse(updateCookieUrl, headers: {
      "Cookie": jwCode[0],
      "Referer": "http://xk.csust.edu.cn/"
    });
    print("updateCookieUrl headers==>\n${updateCookieResponse!.headers}");
    // return updateCookieResponse.headers.value("Set-Cookie")?.split(';')[0];
    return updateCookieResponse.headers.value("Set-Cookie");
  }

  Future getCourseHtml(String cookie, String term, int week) async =>
      await _post('/jsxsd/xskb/xskb_list.do',
          params: FormData.fromMap({'xnxq01id': term, 'zc': week.toString()}),
          headers: {'Cookie': cookie});

  Future getExamHtml(String cookie, String term) async =>
      await _post('/jsxsd/xsks/xsksap_list',
          params: FormData.fromMap({'xnxqid': term, 'xqlbmc': '', 'xqlb': ''}),
          headers: {
            'cookie': cookie,
            'Referer': 'http://xk.csust.edu.cn/jsxsd/xsks/xsksap_query'
          });

  Future getScoreHtml(String cookie, String term) async =>
      await _post('/jsxsd/kscj/cjcx_list',
          params: FormData.fromMap({
            'kksj': term,
            'kcxz': '',
            'kmmc': '',
            'xsfs': 'all',
            'fxkc': '2'
          }),
          headers: {
            'Cookie': cookie,
            'Referer': 'http://xk.csust.edu.cn/jsxsd/kscj/cjcx_query'
          });

  Future getScoreInfoHtml(String cookie, String scoreUrl) async =>
      await _get(scoreUrl, headers: {
        'Cookie': cookie,
      });
}
