import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/common/forumlist/data/forum_item_type.dart';
import 'package:csust_edu_system/common/forumlist/model/forum_item_model.dart';
import 'package:csust_edu_system/common/forumlist/service/forum_item_service.dart';
import 'package:csust_edu_system/common/forumlist/viewmodel/forum_list_view_model.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/forum/viewmodel/forum_tab_list_view_model.dart';
import 'package:provider/provider.dart';

import '../../../homes/detail_home.dart';
import '../../../ui/mycollect/viewmodel/my_collect_view_model.dart';
import '../../../ui/myforum/viewmodel/my_forum_view_model.dart';

/// 帖子Item ViewModel
///
/// @author zzp
/// @since 2023/9/28
/// @version v1.8.8
class ForumItemViewModel
    extends BaseViewModel<ForumItemModel, ForumItemService> {
  ForumItemViewModel({required super.model});

  @override
  ForumItemService? createService() => ForumItemService();

  /// 跳转到帖子详情页
  void navigatorToDetailHome() {
    if (model.forumBean.isAdvertise) {
      service?.clickAdvertise(model.forumBean.id);
    }
    context.push(
      DetailHome(
        forum: model.forumBean,
        stateCallback: (isLike, isCollect) {
          if (model.forumBean.isLike && !isLike) {
            model.forumBean.likeNum--;
          } else if (!model.forumBean.isLike && isLike) {
            model.forumBean.likeNum++;
          }
          model.forumBean.isLike = isLike;
          model.forumBean.isEnshrine = isCollect;
          notifyListeners();
        },
        deleteCallback: (forum) {
          ForumListViewModel viewModel;
          switch (model.type) {
            case ForumItemType.tabForum:
              viewModel = context.read<ForumTabListViewModel>();
              break;
            case ForumItemType.collectForum:
              viewModel = context.read<MyCollectViewModel>();
              break;
            case ForumItemType.myForum:
              viewModel = context.read<MyForumViewModel>();
              break;
          }
          viewModel.removeForum(forum);
        },
      ),
    );
  }

  /// 点赞帖子
  void likeForum() {
    service?.likeForum(
      model.forumBean.id,
      onDataSuccess: (data, msg) {
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
      onDataSuccess: (data, msg) {},
    );
  }
}
