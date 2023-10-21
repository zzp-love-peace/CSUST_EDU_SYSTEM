import 'package:csust_edu_system/common/forumlist/jsonbean/forum_bean.dart';
import 'package:csust_edu_system/common/forumlist/model/forum_list_model.dart';
import 'package:csust_edu_system/common/forumlist/viewmodel/forum_list_view_model.dart';
import 'package:csust_edu_system/ui/myforum/service/my_forum_service.dart';

/// 我的发帖ViewModel
///
/// @author zzp
/// @since 2023/10/21
/// @version v1.8.8
class MyForumViewModel
    extends ForumListViewModel<ForumListModel, MyForumService> {
  MyForumViewModel({required super.model});

  @override
  MyForumService? createService() => MyForumService();

  /// 获取我的发帖列表
  void getMyForumList() {
    service?.getMyForumList(
      onDataSuccess: (data, msg) {
        model.forumList = data.map((json) => ForumBean.fromJson(json)).toList();
        notifyListeners();
      },
    );
  }
}
