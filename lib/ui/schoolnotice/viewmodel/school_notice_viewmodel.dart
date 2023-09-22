import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ui/schoolnotice/jsonbean/school_notice_bean.dart';
import 'package:csust_edu_system/ui/schoolnotice/model/school_notice_model.dart';
import 'package:csust_edu_system/ui/schoolnotice/service/school_notice_service.dart';

/// 学校通知View model
///
/// @author wk
/// @since 2023/9/22
/// @version v1.8.8
class SchoolNoticeViewModel
    extends BaseViewModel<SchoolNoticeModel, SchoolNoticeService> {
  SchoolNoticeViewModel({required super.model});

  @override
  SchoolNoticeService? createService() => SchoolNoticeService();

  ///初始化学校通知详情
  void initSchoolNoticePageData(String cookie, String ggid) {
    service?.getNoticeDetail(cookie, ggid, onDataSuccess: (data, msg) {
      var schoolNoticeBean = SchoolNoticeBean.fromJson(data);
      model.html = schoolNoticeBean.htmlData;
      notifyListeners();
    });
  }
}
