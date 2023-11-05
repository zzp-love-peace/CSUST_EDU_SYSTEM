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

  /// url-获取已读消息接口
  static const getReadMsg = '/message/hasRead';

  /// url-设置消息已读
  static const setMsgRead = '/message/setRead';

  /// url-设置全部消息已读
  static const setAllMsgRead = '/message/setAllRead';

  /// url-获取帖子详情信息
  static const getForumInfo = '/post/detail';

  /// url-获取功能开关
  static const getFunctionSwitchers = '/sCard/judge';

  /// url-根据套餐校区获取卡号
  static const getCardByKind = '/sCard/getCardByKind/50/1';

  /// url-创建订单
  static const createOder = '/sCard/createOrder';

  /// url-用户获取订单
  static const getOrderList = '/sCard/selectOrderList/50/1';

  /// url-用户删除订单
  static const deleteOrder = '/sCard/deleteOrder';

  /// url-查询电费
  static const queryElectricity =
      'http://yktwd.csust.edu.cn:8988/web/Common/Tsm.html';

  /// url-点击广告帖子
  static const clickAdvertise = '/clickAdvertise';

  /// url-点赞广告帖子
  static const likeAdvertise = '/likeAdvertise';

  /// url-点赞
  static const likeForum = '/post/like';

  /// url-收藏
  static const collectForum = '/post/enshrine';

  /// url-获取所有帖子标签
  static const getAllTabs = '/theme/all';

  /// url-根据标签获取帖子列表
  static const getForumListByTabId = '/getForumAdvertise';

  /// url-获取我的发帖列表
  static const getMyForumList = '/post/self';

  /// url-获取我的收藏列表
  static const getMyCollectList = '/enshrine/list';

  /// url-发布帖子
  static const postForum = '/post/write';

  /// url-获取帖子详情
  static const getForumDetail = '/post/detail';

  /// url-删除帖子/评论/回复
  static const deleteForumOrCommentOrReply = '/post/delete';

  /// url-发布评论
  static const postComment = '/comment/write';

  /// url-发布回复
  static const postReply = '/reply/write';

  /// url-举报帖子
  static const reportForum = '/report/add';

  /// url-获取最新版本
  static const getLastVersion = '/getLastVersion';

  /// url-获取所有兼职信息
  static const getAllRecruitInfo = '/recruitInfo/getAll';

  /// url-通过标题获取兼职信息
  static const getRecruitInfoByTitle = '/recruitInfo/getByTitle';

  /// url-通过学期获取成绩
  static const queryScore = '/queryScore';

  /// url-查询成绩详情
  static const queryScoreInfo = '/queryPscj';

  /// url-获取社团类别
  static const getAssociationTabList = '/category/getAll';

  /// url-通过类别获取社团列表
  static const getAssociationInfoByTabId = '/association/get';
}
