import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/common/forumlist/model/forum_model.dart';
import 'package:csust_edu_system/common/forumlist/service/forum_item_service.dart';

///帖子点赞和收藏ViewModel
///
/// @author zzp
/// @since 2023/10/25
/// @version
abstract class ForumLikeAndCollectViewModel<M extends ForumModel,
    S extends ForumItemService> extends BaseViewModel<M, S> {
  ForumLikeAndCollectViewModel({required super.model});

  @override
  S? createService();

  /// 点赞帖子
  void likeForum() {
    service?.likeForum(
      model.forumBean.id,
      onDataSuccess: (data, msg) {
        if (model.forumBean.isLike) {
          model.forumBean.likeNum--;
        } else {
          model.forumBean.likeNum++;
        }
        model.forumBean.isLike = !model.forumBean.isLike;
        notifyListeners();
        if (model.forumBean.isAdvertise) {
          service?.likeAdvertise(model.forumBean.id);
        }
      },
    );
  }

  /// 收藏帖子
  void collectForum() {
    service?.collectForum(
      model.forumBean.id,
      onDataSuccess: (data, msg) {
        model.forumBean.isEnshrine = !model.forumBean.isEnshrine;
        notifyListeners();
      },
    );
  }
}
