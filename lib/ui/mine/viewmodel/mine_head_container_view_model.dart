import 'package:csust_edu_system/arch/baseservice/empty_service.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/mine/model/mine_head_container_model.dart';

import '../../stuinfo/model/stu_info_model.dart';
import '../../stuinfo/page/stu_info_page.dart';

/// 我的页面头部Model
///
/// @author wk
/// @since 2023/11/27
/// @version v1.8.8
class MineHeadContainerViewModel
    extends BaseViewModel<MineHeadContainerModel, EmptyService> {
  MineHeadContainerViewModel({required super.model});

  @override
  EmptyService? createService() => EmptyService();

  /// 更新头像
  ///
  /// [avatar] 新头像url
  void _setAvatar(avatar) {
    model.avatar = avatar;
    notifyListeners();
  }

  /// 更新昵称
  ///
  /// [userName] 新昵称
  void _setUserName(userName) {
    model.userName = userName;
    notifyListeners();
  }

  /// 跳转之个人资料页
  void goToStuInfoPage() {
    context.push<StuInfoModel>(const StuInfoPage()).then((result) {
      if (result != null) {
        _setAvatar(result.resultData.avatar);
        _setUserName(result.resultData.userName);
      }
    });
  }
}
