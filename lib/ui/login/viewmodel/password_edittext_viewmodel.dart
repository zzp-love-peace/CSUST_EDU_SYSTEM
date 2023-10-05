import 'package:csust_edu_system/arch/baseservice/empty_service.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ui/login/model/password_edittext_model.dart';

/// 密码输入框ViewModel
///
/// @author zzp
/// @since 2023/9/12
/// @version v1.8.8
class PasswordEditTextViewModel extends BaseViewModel<PasswordEditTextModel, EmptyService> {
  PasswordEditTextViewModel({required super.model});

  /// 改变密码可见性
  void changePasswordVisible() {
    model.passwordVisible = !model.passwordVisible;
    notifyListeners();
  }

  @override
  EmptyService? createService() => null;
}