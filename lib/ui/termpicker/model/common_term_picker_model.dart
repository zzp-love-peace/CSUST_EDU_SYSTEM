/// 通用学期选择器Model
///
/// @author zzp
/// @since 2023/9/20
/// @version v1.8.8
class CommonTermPickerModel {
  CommonTermPickerModel({required this.nowTerm});
  /// 当前学期
  String nowTerm;
  /// 全部学期
  List allTerm = [];
  /// 当前选中的学期index（selected[0]即为当前index）
  List<int> selected = [0];
}