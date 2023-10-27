import 'package:csust_edu_system/common/forumlist/data/forum_item_type.dart';
import 'package:csust_edu_system/common/forumlist/jsonbean/forum_bean.dart';
import 'package:csust_edu_system/common/forumlist/model/forum_item_model.dart';
import 'package:csust_edu_system/common/forumlist/service/forum_item_service.dart';
import 'package:csust_edu_system/common/forumlist/viewmodel/forum_like_and_collect_view_model.dart';
import 'package:csust_edu_system/common/forumlist/viewmodel/forum_list_view_model.dart';
import 'package:csust_edu_system/data/page_result_code.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/forum/viewmodel/forum_tab_list_view_model.dart';
import 'package:csust_edu_system/ui/forumdetail/page/forum_detail_page.dart';
import 'package:provider/provider.dart';

import '../../../ui/mycollect/viewmodel/my_collect_view_model.dart';
import '../../../ui/myforum/viewmodel/my_forum_view_model.dart';

/// 帖子Item ViewModel
///
/// @author zzp
/// @since 2023/9/28
/// @version v1.8.8
class ForumItemViewModel
    extends ForumLikeAndCollectViewModel<ForumItemModel, ForumItemService> {
  ForumItemViewModel({required super.model});

  @override
  ForumItemService? createService() => ForumItemService();

  /// 跳转到帖子详情页
  void navigatorToDetailHome() {
    if (model.forumBean.isAdvertise) {
      service?.clickAdvertise(model.forumBean.id);
    }
    context
        .push<ForumBean>(ForumDetailPage(forumBean: model.forumBean))
        .then((result) {
      if (result != null) {
        if (result.resultCode == PageResultCode.forumDelete) {
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
          viewModel.removeForum(result.resultData);
        } else if (result.resultCode == PageResultCode.forumStateChange) {
          _updateForum(result.resultData);
        }
      }
    });
  }

  /// 更新帖子
  ///
  /// [newForum] 新帖子
  void _updateForum(ForumBean newForum) {
    model.forumBean.likeNum = newForum.likeNum;
    model.forumBean.commentNum = newForum.commentNum;
    model.forumBean.isLike = newForum.isLike;
    model.forumBean.isEnshrine = newForum.isEnshrine;
    notifyListeners();
  }
}
