import 'package:csust_edu_system/arch/baseservice/empty_service.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ui/telephonecard/model/show_picker_model.dart';

/// 电话卡选择器View Model
///
/// @author wk
/// @since 2023/9/25
/// @version v1.8.8
class ShowPickerViewModel extends BaseViewModel<ShowPickerModel, EmptyService> {
  ShowPickerViewModel({required super.model});

  /// 设置当前选择器值
  ///
  /// [text] 当前选择器值
  void setText(String text) {
    model.text = text;
    notifyListeners();
  }
}
