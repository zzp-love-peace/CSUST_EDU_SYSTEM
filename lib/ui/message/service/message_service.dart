
import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/ass/url_assets.dart';

import '../../../util/typedef_util.dart';

/// 消息通知Service
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.23
class MessageService extends BaseService{
  /// 获得未读消息
  void getUnreadMsg({required OnDataSuccess<KeyList> onDataSuccess}){
    get(UrlAssets.getUnreadMsg, onDataSuccess: onDataSuccess);
  }
  /// 获得已读消息
  void getReadMsg({required OnDataSuccess<KeyList> onDataSuccess}){
    get(UrlAssets.getReadMsg, onDataSuccess: onDataSuccess);
  }

  void setMsgRead(int id, int type, {required OnDataSuccess<KeyList> onDataSuccess}){
    post(UrlAssets.setMsgRead,params:{'id': id, 'type': type} ,onDataSuccess: onDataSuccess);
  }
  void setAllMsgRead({required OnDataSuccess<KeyList> onDataSuccess}){
    post(UrlAssets.setAllMsgRead, onDataSuccess: onDataSuccess);
  }

  /// 获得论坛info 这里是将原本的_pushDetail函数拆成了getForum和push页面，push部分
  /// 留到viewModel中实现
  void getForumInfo(int id ,{required OnDataSuccess<KeyMap> onDataSuccess}){
    get(UrlAssets.getForumInfo,params:{"id": id}  ,onDataSuccess: onDataSuccess);
  }

}