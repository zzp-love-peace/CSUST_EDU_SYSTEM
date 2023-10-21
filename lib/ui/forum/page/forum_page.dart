import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/forum/model/forum_model.dart';
import 'package:csust_edu_system/ui/forum/view/forum_tab_list_view.dart';
import 'package:csust_edu_system/ui/forum/viewmodel/forum_tab_list_view_model.dart';
import 'package:csust_edu_system/ui/forum/viewmodel/forum_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../homes/write_forum_home.dart';

/// 论坛页
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class ForumPage extends StatelessWidget {
  const ForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ForumViewModel(model: ForumModel()))
      ],
      child: const ForumHome(),
    );
  }
}

/// 论坛页Home
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class ForumHome extends StatelessWidget {
  const ForumHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ConsumerView<ForumViewModel>(
      onInit: (viewModel) {
        viewModel.getAllTabs();
      },
      builder: (ctx, viewModel, _) {
        return DefaultTabController(
          length: viewModel.model.tabList.length,
          child: Scaffold(
            appBar: CommonAppBar.create(
              StringAssets.forum,
              bottom: TabBar(
                labelColor: Colors.white,
                labelStyle: const TextStyle(fontSize: 16),
                tabs: viewModel.model.tabList
                    .map((tab) => Tab(text: tab))
                    .toList(),
                isScrollable: true,
              ),
            ),
            body: TabBarView(
                children: viewModel.model.tabIdList
                    .map((id) => ForumTabListView(tabId: id))
                    .toList()),
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButton: FloatingActionButton(
              foregroundColor: Colors.white,
              onPressed: () {
                context.push(WriteForumHome(
                  tabs: viewModel.model.tabList.sublist(1),
                  tabsId: viewModel.model.tabIdList.sublist(1),
                  callback: (forum, id) {
                    viewModel
                        .readSonViewModel<ForumTabListViewModel>(id)
                        ?.addForumAtFirst(forum);
                    viewModel
                        .readSonViewModel<ForumTabListViewModel>(0)
                        ?.addForumAtFirst(forum);
                  },
                ));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(Icons.edit),
            ),
          ),
        );
      },
    );
  }
}
