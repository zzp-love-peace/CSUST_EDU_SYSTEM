import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/common/forumlist/data/forum_item_type.dart';
import 'package:csust_edu_system/common/forumlist/view/forum_list_view.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/forum/viewmodel/forum_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

import '../model/forum_tab_list_model.dart';
import '../viewmodel/forum_tab_list_view_model.dart';

/// 标签帖子列表View
///
/// @author zzp
/// @since 2023/10/19
/// @version v1.8.8
class ForumTabListView extends StatefulWidget {
  const ForumTabListView({super.key, required this.tabId});

  /// 标签id
  final int tabId;

  @override
  State<ForumTabListView> createState() => _ForumTabListViewState();
}

class _ForumTabListViewState extends State<ForumTabListView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (_) =>
          ForumTabListViewModel(model: ForumTabListModel(tabId: widget.tabId)),
      child: Builder(
        builder: (innerContext) {
          var forumTabListViewModel =
              innerContext.readViewModel<ForumTabListViewModel>();
          var forumViewModel = innerContext.read<ForumViewModel>();
          forumViewModel.registerSonViewModel(
              widget.tabId, forumTabListViewModel);
          return EasyRefresh(
            header: BezierCircleHeader(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            footer: BallPulseFooter(color: Theme.of(context).primaryColor),
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 1200), () {
                forumTabListViewModel.onRefresh();
              });
            },
            onLoad: () async {
              await Future.delayed(const Duration(milliseconds: 1200), () {
                forumTabListViewModel.onLoad();
              });
            },
            child: ConsumerView<ForumTabListViewModel>(
              onInit: (viewModel) {
                viewModel.getFormList();
              },
              builder: (ctx, viewModel, _) {
                return ForumListView(
                  forumList: viewModel.model.forumList,
                  forumItemType: ForumItemType.tabForum,
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
