import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ui/school/db/school_notice_db_manager.dart';
import 'package:csust_edu_system/ui/school/jsonbean/banner_bean.dart';
import 'package:csust_edu_system/ui/school/jsonbean/school_notice_bean.dart';
import 'package:csust_edu_system/ui/school/model/school_model.dart';
import 'package:csust_edu_system/ui/school/service/school_service.dart';

/// 校园ViewModel
///
/// @author zzp
/// @since 2023/10/1
/// @version v1.8.8
class SchoolViewModel extends BaseViewModel<SchoolModel, SchoolService> {
  SchoolViewModel({required super.model});

  @override
  SchoolService? createService() => SchoolService();

  /// 初始化通知和轮播图数据
  void initNoticeAndBannerData(String cookie) {
    getNoticeList(cookie);
    _getBannerImg();
  }

  /// 获取教务通知list
  ///
  /// [cookie] cookie
  void getNoticeList(String cookie) {
    service?.getNoticeList(
      cookie: cookie,
      onDataSuccess: (data, code) {
        model.noticeList =
            data.map((json) => SchoolNoticeBean.fromJson(json)).toList();
        notifyListeners();
        for (var notice in model.noticeList) {
          SchoolNoticeDBManager.insertSchoolNotice(notice);
        }
      },
      onFinish: (isSuccess) {
        if (!isSuccess) {
          SchoolNoticeDBManager.getAllSchoolNotice().then(
            (data) {
              model.noticeList = data;
              notifyListeners();
            },
          );
        }
      },
    );
  }

  /// 获取轮播图图片
  void _getBannerImg() {
    service?.getBannerImg(onDataSuccess: (data, code) {
      model.bannerList = data.map((json) => BannerBean.fromJson(json)).toList();
      notifyListeners();
    });
  }
}
