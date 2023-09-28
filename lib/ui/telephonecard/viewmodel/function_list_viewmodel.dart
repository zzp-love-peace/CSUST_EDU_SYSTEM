import 'package:csust_edu_system/arch/baseservice/empty_service.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ui/telephonecard/model/function_list_model.dart';

/// 电话卡功能列表ViewModel
///
/// @author wk
/// @since 2023/9/25
/// @version v1.8.8

class FunctionListViewModel
    extends BaseViewModel<FunctionListModel, EmptyService> {
  FunctionListViewModel({required super.model});

  /// 改变列表展开状态
  void setIsExpanded() {
    model.isExpanded = !model.isExpanded;
    notifyListeners();
  }
}
