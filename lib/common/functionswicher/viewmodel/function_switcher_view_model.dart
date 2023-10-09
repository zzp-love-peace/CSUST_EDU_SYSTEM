import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/functionswicher/model/function_switcher_model.dart';
import 'package:csust_edu_system/common/functionswicher/service/function_switcher_service.dart';

/// 功能开关ViewModel
///
/// @author zzp
/// @since 2023/10/8
/// @version v1.8.8
class FunctionSwitcherViewModel
    extends BaseViewModel<FunctionSwitcherModel, FunctionSwitcherService> {
  FunctionSwitcherViewModel({required super.model});

  @override
  FunctionSwitcherService? createService() => FunctionSwitcherService();

  /// 获取功能开关
  void getFunctionSwitchers() {
    service?.getFunctionSwitchers(
      onDataSuccess: (data, msg) {
        model.functionSwitchers = data.map((key, value) =>
            MapEntry<String, bool>(key, value == StringAssets.one));
        notifyListeners();
      },
    );
  }
}
