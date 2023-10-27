import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ui/recruit/jsonbean/recruit_bean.dart';
import 'package:csust_edu_system/ui/recruit/model/recruit_model.dart';
import 'package:csust_edu_system/ui/recruit/service/recruit_sercice.dart';

/// 兼职ViewModel
///
/// @author zzp
/// @since 2023/10/27
/// @version v1.8.8
class RecruitViewModel extends BaseViewModel<RecruitModel, RecruitService> {
  RecruitViewModel({required super.model});

  @override
  RecruitService? createService() => RecruitService();

  /// 获取所有兼职信息
  void getAllRecruitInfo() {
    service?.getAllRecruitInfo(
      onDataSuccess: (data, msg) {
        model.recruitList =
            data.map((json) => RecruitBean.fromJson(json)).toList();
        notifyListeners();
      },
    );
  }

  /// 通过标题获取兼职信息
  ///
  /// [title] 标题
  void getRecruitInfoByTitle(String title) {
    service?.getRecruitInfoByTitle(
      title: title,
      onDataSuccess: (data, msg) {
        model.recruitList =
            data.map((json) => RecruitBean.fromJson(json)).toList();
        notifyListeners();
      },
    );
  }
}
