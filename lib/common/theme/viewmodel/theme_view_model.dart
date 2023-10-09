import 'package:csust_edu_system/arch/baseservice/empty_service.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/common/theme/model/theme_model.dart';

/// 主题ViewModel
///
/// @author zzp
/// @since 2023/10/8
/// @version v1.8.8
class ThemeViewModel extends BaseViewModel<ThemeModel, EmptyService> {
  ThemeViewModel({required super.model});

  @override
  EmptyService? createService() => null;

  /// 设置主题色
  ///
  /// [colorKey] 颜色key
  void setThemeColor(String colorKey) {
    model.themeColorKey = colorKey;
    notifyListeners();
  }
}
