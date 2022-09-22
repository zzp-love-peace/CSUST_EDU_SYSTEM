import 'dart:async';
import 'package:csust_edu_system/utils/my_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


class HttpManager {
  static final HttpManager _instance = HttpManager._internal();

  static const _baseUrl = 'http://finalab.cn:8989';

  // static const _baseUrl = 'http://47.97.205.5:8989';

  // static const _baseUrl = 'http://1.117.154.123:8081';
  // static const _baseUrl = 'http://101.34.59.239:8081';
  Dio? _dio;

  factory HttpManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal() {
    _dio ??= Dio(BaseOptions(baseUrl: _baseUrl, connectTimeout: 8000));
    // _dio ??= Dio(BaseOptions(baseUrl: _baseUrl, connectTimeout: 8000));
  }

  static HttpManager getInstance() => _instance;

  ///通用的GET请求
  Future _get(String path, {params, header}) async {
    Response? response;
    try {
      response = await _dio?.get(path,
          queryParameters: params,
          options: Options(headers: {"token": header}));
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

  ///通用的POST请求
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

  Future<Map> login(String username, String password) async =>
      await _post('/login',
          params: FormData.fromMap({
            'stuNum': username,
            'password': password,
            'version': '$appName$version${getAppSuffix()}'
          }));

  Future<Map> getDateData(String cookie, String token) async =>
      await _post('/getBasicData',
          params: FormData.fromMap({'cookie': cookie}),
          headers: {"token": token});

  Future<Map> getStuInfo(String cookie, String token) async =>
      await _post('/getStuInfo',
          params: FormData.fromMap({'cookie': cookie}),
          headers: {"token": token});

  Future<Map> setStuInfo(String token, String username, bool sex) async =>
      await _post('/setStuInfo',
          params: FormData.fromMap({'username': username, 'sex': sex}),
          headers: {"token": token});

  Future<Map> setHeadImg(String token, String imgPath) async =>
      await _post(
          '/setHeadImg',
          params: FormData.fromMap(
              {'img': await MultipartFile.fromFile(imgPath)}),
          headers: {"token": token});

  Future<Map> restoreHeadImg(String cookie, String token) async =>
      await _post('/restoreHeadImg',
          params: FormData.fromMap({'cookie': cookie}),
          headers: {"token": token});

  Future<Map> refreshStuInfo(String cookie, String token) async =>
      await _post('/refreshStuInfo',
          params: FormData.fromMap({'cookie': cookie}),
          headers: {"token": token});

  Future<Map> getHeadImage(String cookie, String token) async =>
      await _post('/getHeadImg',
          params: FormData.fromMap({'cookie': cookie}),
          headers: {"token": token});

  Future<Map> getAllSemester(String cookie, String token) async =>
      await _post('/getAllSemester',
          params: FormData.fromMap({'cookie': cookie}),
          headers: {"token": token});

  Future<Map> queryScore(String token, String cookie, String term) async =>
      await _post('/queryScore',
          params: FormData.fromMap({'cookie': cookie, 'xueqi': term}),
          headers: {"token": token});

  Future<Map> queryExam(String token, String cookie, String term) async =>
      await _post('/getKsap',
          params: FormData.fromMap({'cookie': cookie, 'xueqi': term}),
          headers: {"token": token});

  Future<Map> queryScoreInfo(String token, String cookie, String url) async =>
      await _post('/queryPscj',
          params: FormData.fromMap({'cookie': cookie, 'pscjUrl': url}),
          headers: {"token": token});

  Future<Map> queryCourse(String token, String cookie, String term,
      String weekNum) async =>
      await _post('/getCourse',
          params: FormData.fromMap(
              {'cookie': cookie, 'xueqi': term, 'zc': weekNum}),
          headers: {"token": token});

  // 获取教务通知列表
  Future<Map> getNoticeList(String cookie, String token) async =>
      await _post('/getNoticeList',
          params: FormData.fromMap({'cookie': cookie}),
          headers: {"token": token});

  Future<Map> getNoticeDetail(String cookie, String token, String ggid) async =>
      await _post('/getNoticeDetail',
          params: FormData.fromMap({'cookie': cookie, 'ggid': ggid}),
          headers: {"token": token});

  Future<Map> addAdvice(String token, String content, String phone,
      String name) async =>
      await _post('/advice/add',
          params: FormData.fromMap(
              {'content': content, 'phone': phone, 'name': name}),
          headers: {"token": token});

  /*/
  论坛
   */
  Future<Map> getAllTab(String token) async =>
      await _get('/theme/all', header: token);

  Future<Map> getFormListByTabId(String token, int tabId, int page,
      int rows) async =>
      await _post('/post/index',
          params: {'themeId': tabId, 'page': page, 'rows': rows},
          headers: {"token": token});

  Future<Map> postForum(String token, int themeId, String content,
      bool isAnonymous, List<MultipartFile> images) async =>
      await _post('/post/write',
          params: FormData.fromMap({
            'themeId': themeId,
            'content': content,
            'isAnonymous': isAnonymous,
            'images': images
          }),
          headers: {"token": token});

  Future<Map> likeForum(String token, int id) async =>
      await _get('/post/like', params: {'id': id}, header: token);

  Future<Map> collectForum(String token, int id) async =>
      await _get('/post/enshrine', params: {'id': id}, header: token);

  Future<Map> getMyForums(String token) async =>
      await _get('/post/self', header: token);

  Future<Map> getMyCollects(String token) async =>
      await _get('/enshrine/list', header: token);

  Future<Map> getForumInfo(String token, int id) async =>
      await _get('/post/detail', params: {"id": id}, header: token);

  Future<Map> deleteForum(String token, int postId) async =>
      await _post('/post/delete',
          params: {'postId': postId}, headers: {"token": token});

  Future<Map> deleteComment(String token, int commentId) async =>
      await _post('/post/delete',
          params: {'commentId': commentId}, headers: {"token": token});

  Future<Map> deleteReply(String token, int replyId) async =>
      await _post('/post/delete',
          params: {'replyId': replyId}, headers: {"token": token});

  Future<Map> postComment(String token, int postId, String content) async =>
      await _post('/comment/write',
          params: {'postId': postId, 'content': content},
          headers: {"token": token});

  Future<Map> postReply(String token, int commentId, int replyId,
      String content) async =>
      await _post('/reply/write', params: {
        'commentId': commentId,
        'replyId': replyId,
        'content': content
      }, headers: {
        "token": token
      });

  Future<Map> getUnreadMsg(String token) async =>
      await _get('/message/unread', header: token);

  Future<Map> getReadMsg(String token) async =>
      await _get('/message/hasRead', header: token);

  Future<Map> setAllMsgRead(String token) async =>
      await _post('/message/setAllRead', headers: {"token": token});

  Future<Map> setMsgRead(String token, int id, int type) async =>
      await _post('/message/setRead',
          params: {'id': id, 'type': type}, headers: {"token": token});

  Future<Map> getNotifications(String token) async =>
      await _get('/notice/get', header: token);

  Future<Map> reportComment(String token, int postId) async =>
      await _post('/report/add', params:  FormData.fromMap({'postId': postId}), headers: {"token": token});

  Future<Map> getAssTabs(String token) async =>
      await _get('/category/getAll', header: token);

  Future<Map> getAssByTab(String token, int id) async =>
      await _get('/association/get', params: {'id': id} , header: token);

  Future<Map> getLastVersion(String token, String form) async =>
      await _get('/getLastVersion', params: {'flag': 2, 'form': form} , header: token);

  Future<Map> getAllRecruitInfo(String token) async =>
      await _get('/recruitInfo/getAll', header: token);

  Future<Map> getRecruitInfoByTitle(String token, String title) async =>
      await _get('/recruitInfo/getByTitle', params: {'name': title}, header: token);

  Future<Map> getBannerImg(String token) async =>
      await _get('/loopImg/getAll', header: token);

  queryElectricity(String jsonData) async =>
      await _post('http://yktwd.csust.edu.cn:8988/web/Common/Tsm.html',
          params: {
            'jsondata': jsonData,
            'funname': 'synjones.onecard.query.elec.roominfo',
            'json': true
          },
          contentType: Headers.formUrlEncodedContentType);

  Future<Map> getAllCourseOfTerm(String cookie, String token,
      String term) async =>
      await _post('/getCourse',
          params: FormData.fromMap({'cookie': cookie, 'xueqi': term, 'zc': 0}), headers: {"token": token});

  // 并行获取所有周的课程表
  // Future<List> getAllCourse(String token, String cookie, String term,
  //     int totalWeek) async {
  //   List result = [];
  //   List<Future> futures = [];
  //   // print(totalWeek);
  //   for (int i = 1; i <= totalWeek; i++) {
  //     futures.add(HttpManager().queryCourse(token, cookie, term, i.toString()));
  //   }
  //   var response = await Future.wait(futures);
  //   for (Map value in response) {
  //     if (value.isNotEmpty) {
  //       // print(value);
  //       if (value['code'] == 200) {
  //         result.add(value['data']);
  //       } else {
  //         if (kDebugMode) {
  //           print('出异常了');
  //         }
  //         throw Exception('获取课表出错了');
  //       }
  //     } else {
  //       if (kDebugMode) {
  //         print('出异常了');
  //       }
  //       throw Exception('获取课表出错了');
  //     }
  //   }
  //   return result;
  // }

// 串行获取所有周的课程表
// Future<List> getAllCourse(
//     String token, String cookie, String term, int totalWeek) async {
//   List result = [];
//   // List<Future> futures = [];
//   print(totalWeek);
//   for (int i = 1; i <= totalWeek; i++) {
//     var value =
//         await HttpManager().queryCourse(token, cookie, term, i.toString());
//     await Future.delayed(const Duration(milliseconds: 1500));
//     if (value.isNotEmpty) {
//       print(i);
//       if (value['code'] == 200) {
//         result.add(value['data']);
//       } else {
//         if (kDebugMode) {
//           print('出异常了');
//         }
//         throw Exception('获取课表出错了');
//       }
//     } else {
//       if (kDebugMode) {
//         print('出异常了');
//       }
//       throw Exception('获取课表出错了');
//     }
//   }
//   return result;
// }
}
