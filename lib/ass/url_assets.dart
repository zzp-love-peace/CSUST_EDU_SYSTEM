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

  /// url-获取全部学期接口
  static const getAllTerm = '/getAllSemester';

  /// url-获取某一周课程表接口
  static const getWeekCourse = '/getCourse';

  /// url-获取学校通知详情接口
  static const getNoticeDetail = '/getNoticeDetail';

  /// url-获取教务通知list接口
  static const getNoticeList = '/getNoticeList';

  /// url-获取轮播图图片接口
  static const getBannerImg = '/loopImg/getAll';

  /// url-发送意见或建议
  static const postAdvice = '/advice/add';

  ///url-获取已读消息接口
  static const getReadMsg = '/message/hasRead';

  ///url-设置消息已读
  static const setMsgRead = '/message/setRead';

  ///url-设置全部消息已读
  static const setAllMsgRead = '/message/setAllRead';

  ///url-获取帖子详情信息
  static const getForumInfo = '/post/detail';

  /// url-根据套餐校区获取卡号
  static const getCardByKind = '/sCard/getCardByKind/50/1';

  /// url-创建订单
  static const createOder = '/sCard/createOrder';

  /// url-用户获取订单
  static const getOrderList = '/sCard/selectOrderList/50/1';

  /// url-用户删除订单
  static const deleteOrder = '/sCard/deleteOrder';
}
