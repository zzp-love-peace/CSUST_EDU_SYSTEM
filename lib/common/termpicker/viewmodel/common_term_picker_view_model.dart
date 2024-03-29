import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/common/termpicker/model/common_term_picker_model.dart';
import 'package:csust_edu_system/common/termpicker/service/common_term_picker_service.dart';
import 'package:csust_edu_system/util/sp/sp_data.dart';

import '../../../data/date_info.dart';

/// 通用学期选择器ViewModel
///
/// @author zzp
/// @since 2023/9/20
/// @version v1.8.8
class CommonTermPickerViewModel
    extends BaseViewModel<CommonTermPickerModel, CommonTermPickerService> {
  CommonTermPickerViewModel({required super.model});

  @override
  CommonTermPickerService? createService() => CommonTermPickerService();

  /// sp-学期列表
  final _spTermList =
      SpData<List<String>>(key: KeyAssets.termList, defaultValue: []);

  /// 设置当前学期
  ///
  /// [nowTerm] 当前学期
  void setNowTerm(String nowTerm) {
    model.nowTerm = nowTerm;
    notifyListeners();
  }

  /// 获取全部学期
  ///
  /// [cookie] cookie
  /// [onDataSuccess] 获取数据成功回调
  void getAllTerm(String cookie) {
    if (model.allTerm.isEmpty) {
      service?.getAllTerm(
        cookie: cookie,
        onDataSuccess: (data, msg) {
          model.allTerm = data.map((e) => e.toString()).toList();
          if (DateInfo.nowTerm.isEmpty) {
            DateInfo.nowTerm = model.allTerm[model.allTerm.length - 2];
          }
          model.nowTerm = DateInfo.nowTerm;
          _spTermList.set(model.allTerm);
          notifyListeners();
        },
        onFinish: (isSuccess) {
          if (!isSuccess) {
            model.allTerm = _spTermList.get();
            if (DateInfo.nowTerm.isEmpty && model.allTerm.isNotEmpty) {
              DateInfo.nowTerm = model.allTerm[model.allTerm.length - 2];
            }
            model.nowTerm = DateInfo.nowTerm;
            notifyListeners();
          }
        },
      );
    }
  }
}
