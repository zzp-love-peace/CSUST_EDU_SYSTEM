import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/forum/jsonbean/forum_tab_bean.dart';
import 'package:csust_edu_system/ui/forum/model/forum_model.dart';
import 'package:csust_edu_system/ui/forum/service/forum_service.dart';

/// 论坛ViewModel
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class ForumViewModel extends BaseViewModel<ForumModel, ForumService> {
  ForumViewModel({required super.model});

  @override
  ForumService? createService() => ForumService();

  /// 获取所有帖子标签
  void getAllTabs() {
    service?.getAllTabs(
      onDataSuccess: (data, msg) {
        List<ForumTabBean> forumTabBeanList =
            data.map((json) => ForumTabBean.fromJson(json)).toList();
        model.tabList = forumTabBeanList.map((e) => e.tabName).toList();
        model.tabIdList = forumTabBeanList.map((e) => e.tabId).toList();
        model.tabList.insert(0, StringAssets.all);
        model.tabIdList.insert(0, 0);
        notifyListeners();
      },
    );
  }
}
