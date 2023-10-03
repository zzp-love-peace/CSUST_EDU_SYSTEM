class UrlAssets {
  /// url-登录接口
  static const login = '/login';

  /// url-获取日期数据接口
  static const getBasicData = '/getBasicData';

  /// url-获取学生信息接口
  static const getStuInfo = '/getStuInfo';

  /// url-获取未读消息接口
  static const getUnreadMsg = '/message/unread';

  /// url-获取通知接口
  /// 这里的notice并非学校官方的通告，而是教务系统的通知，后端应考虑改为notification以保持和前端组件一致
  static const getNotifications = '/notice/get';

  /// url-获取全部学期
  static const getAllTerm = '/getAllSemester';

  /// url-获取某一周课程表
  static const getWeekCourse = '/getCourse';

  /// url-获取学校通知详情接口
  static const getNoticeDetail = '/getNoticeDetail';

  /// url-根据套餐校区获取卡号
  static const getCardByKind = '/sCard/getCardByKind/50/1';

  /// url-创建订单
  static const createOder = '/sCard/createOrder';

  /// url-用户获取订单
  static const getOrderList = '/sCard/selectOrderList/50/1';

  /// url-用户删除订单
  static const deleteOrder = '/sCard/deleteOrder';
}
