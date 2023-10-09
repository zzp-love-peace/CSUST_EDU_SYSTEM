import 'package:csust_edu_system/arch/baseservice/empty_service.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/themecolor/model/theme_color_model.dart';
import 'package:csust_edu_system/util/sp/sp_data.dart';
import 'package:provider/provider.dart';

import '../../../common/theme/data/theme_color_data.dart';
import '../../../common/theme/viewmodel/theme_view_model.dart';

/// 主题色ViewModel
///
/// @author zzp
/// @since 2023/10/9
/// @version v1.8.8
class ThemeColorViewModel extends BaseViewModel<ThemeColorModel, EmptyService> {
  ThemeColorViewModel({required super.model});

  @override
  EmptyService? createService() => null;

  final SpData<String> _spColor =
      SpData(key: KeyAssets.color, defaultValue: StringAssets.blue);

  /// 设置单选按钮值
  ///
  /// [index] 选择的单选按钮下标
  void setGroupValueByIndex(int index) {
    model.groupValue = model.colorNames[index];
    context.read<ThemeViewModel>().setThemeColor(model.groupValue);
    _spColor.set(model.groupValue);
    notifyListeners();
  }

  /// 设置单选按钮值
  ///
  /// [groupValue] 单选按钮值
  void setGroupValue(String? groupValue) {
    if (groupValue == null) return;
    model.groupValue = groupValue;
    context.read<ThemeViewModel>().setThemeColor(groupValue);
    _spColor.set(groupValue);
    notifyListeners();
  }

  /// 初始化数据
  void initData() {
    themeColorMap.forEach((key, value) {
      model.colorNames.add(key);
      model.colors.add(value);
    });
    model.groupValue = _spColor.get();
    notifyListeners();
  }
}
