/// 电话卡选择器model
///
/// @author wk
/// @since 2023/9/25
/// @version v1.8.8
class TelephonePickerModel {
  TelephonePickerModel({required this.text, required this.pickerData});

  /// 当前选择器值
  String text;

  /// 选择器列表
  List pickerData;
}
