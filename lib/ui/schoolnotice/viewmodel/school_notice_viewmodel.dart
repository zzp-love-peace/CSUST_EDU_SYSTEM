import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ui/school/db/school_notice_db_manager.dart';
import 'package:csust_edu_system/ui/schoolnotice/jsonbean/school_notice_data_bean.dart';
import 'package:csust_edu_system/ui/schoolnotice/model/school_notice_model.dart';
import 'package:csust_edu_system/ui/schoolnotice/service/school_notice_service.dart';
import 'package:csust_edu_system/util/log.dart';

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
    service?.getNoticeDetail(
      cookie,
      ggid,
      onDataSuccess: (data, msg) {
        var schoolNoticeBean = SchoolNoticeDataBean.fromJson(data);
        model.html = schoolNoticeBean.htmlData;
        notifyListeners();
        SchoolNoticeDBManager.updateSchoolNoticeHtml(model.html, model.ggid);
      },
      onFinish: (isSuccess) {
        if (!isSuccess) {
          SchoolNoticeDBManager.getSchoolNoticeHtmlByGgid(model.ggid).then(
            (html) {
              Log.d(html);
              if (html != null) {
                model.html = html;
                notifyListeners();
              }
            },
          );
        }
      },
    );
  }
}
