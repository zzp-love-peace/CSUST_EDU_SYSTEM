import 'package:csust_edu_system/arch/baseservice/empty_service.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/bottomtab/model/bottom_tab_model.dart';

/// 底部导航栏ViewModel类
///
/// @author zzp
/// @since 2023/9/19
/// @version v1.8.8
class BottomTabViewModel extends BaseViewModel<BottomTabModel, EmptyService> {
  BottomTabViewModel({required super.model});

  /// 上一次back触发时间
  DateTime? _lastBackTime;

  /// 改变页面index
  ///
  /// [index] 下标
  void setCurrentPageIndex(int index) {
    model.currentIndex = index;
    notifyListeners();
  }


  /// 是否要退出
  Future<bool> isExit() {
    if (_lastBackTime == null ||
        DateTime.now().difference(_lastBackTime!) >
            const Duration(milliseconds: 2500)) {
      _lastBackTime = DateTime.now();
      StringAssets.backAgain.showToast();
      return Future.value(false);
    }
    return Future.value(true);
  }
}