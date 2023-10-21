import 'package:csust_edu_system/common/forumlist/jsonbean/forum_bean.dart';
import 'package:csust_edu_system/common/forumlist/viewmodel/forum_list_view_model.dart';
import 'package:csust_edu_system/ui/forum/jsonbean/forum_tab_list_bean.dart';
import 'package:csust_edu_system/ui/forum/service/forum_tab_list_service.dart';

import '../model/forum_tab_list_model.dart';

/// 标签帖子列表ViewModel
///
/// @author zzp
/// @since 2023/10/19
/// @version v1.8.8
class ForumTabListViewModel
    extends ForumListViewModel<ForumTabListModel, ForumTabListService> {
  ForumTabListViewModel({required super.model});

  @override
  ForumTabListService? createService() => ForumTabListService();

  /// 添加帖子在列表头
  ///
  /// [forumBean] 帖子
  void addForumAtFirst(ForumBean forumBean) {
    model.forumList.insert(0, forumBean);
    notifyListeners();
  }

  /// 上拉刷新
  void onRefresh() {
    model.curPage = 1;
    getFormList();
  }

  /// 下滑加载
  void onLoad() {
    model.curPage++;
    if (model.curPage <= model.totalPages) {
      getFormList();
    }
  }

  /// 获取帖子列表
  void getFormList() {
    service?.getForumListByTabId(
      tabId: model.tabId,
      page: model.curPage,
      rows: model.rows,
      onDataSuccess: (data, msg) {
        var forumTabListBean = ForumTabListBean.fromJson(data);
        model.totalPages = (forumTabListBean.totalCount / model.rows).ceil();
        if (model.curPage == 1) {
          model.forumList = forumTabListBean.forumList;
        } else {
          for (var item in forumTabListBean.forumList) {
            if (!model.forumList.contains(item)) {
              model.forumList.add(item);
            }
          }
        }
        notifyListeners();
      },
    );
  }
}
