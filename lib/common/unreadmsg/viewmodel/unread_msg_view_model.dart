import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/common/unreadmsg/model/unread_msg_model.dart';
import 'package:csust_edu_system/common/unreadmsg/service/unread_msg_service.dart';

/// 未读消息ViewModel
///
/// @author zzp
/// @since 2023/9/19
/// @version v1.8.8
class UnreadMsgViewModel
    extends BaseViewModel<UnreadMsgModel, UnreadMsgService> {
  UnreadMsgViewModel({required super.model});

  @override
  UnreadMsgService? createService() => UnreadMsgService();

  /// 获取未读消息
  void getUnreadMsg() {
    service?.getUnreadMsg(onDataSuccess: (data, msg) {
      setHasUnreadMsg(data.isNotEmpty);
    });
  }

  /// 设置是否有未读消息
  void setHasUnreadMsg(bool hasUnreadMsg) {
    model.hasUnreadMsg = hasUnreadMsg;
    notifyListeners();
  }
}