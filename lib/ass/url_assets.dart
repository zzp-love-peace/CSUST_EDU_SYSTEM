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
}
