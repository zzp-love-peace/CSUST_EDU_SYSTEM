import 'package:csust_edu_system/common/forumlist/model/forum_list_model.dart';
import 'package:csust_edu_system/common/forumlist/viewmodel/forum_list_view_model.dart';
import 'package:csust_edu_system/ui/mycollect/service/my_collect_service.dart';

import '../../../common/forumlist/jsonbean/forum_bean.dart';

/// 我的收藏ViewModel
///
/// @author zzp
/// @since 2023/10/21
/// @version v1.8.8
class MyCollectViewModel
    extends ForumListViewModel<ForumListModel, MyCollectService> {
  MyCollectViewModel({required super.model});

  @override
  MyCollectService? createService() => MyCollectService();

  /// 获取我的收藏列表
  void getMyCollectList() {
    service?.getMyCollectList(
      onDataSuccess: (data, msg) {
        model.forumList = data.map((json) => ForumBean.fromJson(json)).toList();
        notifyListeners();
      },
    );
  }
}
