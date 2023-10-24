import 'package:csust_edu_system/arch/baseservice/empty_service.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/common/versionchecker/model/version_update_dialog_model.dart';

/// 版本更新Dialog ViewModel
///
/// @author zzp
/// @since 2023/10/24
/// @version v1.8.8
class VersionUpdateDialogViewModel
    extends BaseViewModel<VersionUpdateDialogModel, EmptyService> {
  VersionUpdateDialogViewModel({required super.model});

  @override
  EmptyService? createService() => null;

  /// 设置当前进度
  ///
  /// [curProgress] 当前进度
  void setCurProgress(int curProgress) {
    model.curProgress = curProgress;
    notifyListeners();
  }
}
