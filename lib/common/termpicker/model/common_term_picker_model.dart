import '../../picker/common_picker.dart';

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
  List<String> allTerm = [];

  /// 通用选择器
  final CommonPicker<String> picker = CommonPicker<String>();
}
