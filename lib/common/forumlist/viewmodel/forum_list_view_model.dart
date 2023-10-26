import 'package:csust_edu_system/arch/baseservice/base_service.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/common/forumlist/jsonbean/forum_bean.dart';
import 'package:csust_edu_system/common/forumlist/model/forum_list_model.dart';

/// 帖子列表ViewModel
///
/// @author zzp
/// @since 2023/10/20
/// @version v1.8.8
abstract class ForumListViewModel<M extends ForumListModel,
    S extends BaseService> extends BaseViewModel<M, S> {
  ForumListViewModel({required super.model});

  /// 删除帖子
  ///
  /// [forumBean] 帖子
  void removeForum(ForumBean forumBean) {
    model.forumList.remove(forumBean);
    notifyListeners();
  }

  /// 更新帖子
  ///
  /// [oldForum] 老帖子
  /// [newForum] 新帖子
  void updateForum(ForumBean oldForum, ForumBean newForum) {
    model.forumList[model.forumList.indexOf(oldForum)] = newForum;
    notifyListeners();
  }
}
