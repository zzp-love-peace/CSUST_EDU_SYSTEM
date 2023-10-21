import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/common/forumlist/data/forum_item_type.dart';
import 'package:csust_edu_system/common/forumlist/model/forum_list_model.dart';
import 'package:csust_edu_system/common/forumlist/view/forum_list_view.dart';
import 'package:csust_edu_system/ui/myforum/viewmodel/my_forum_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

/// 我的发帖页
///
/// @author zzp
/// @since 2023/10/21
/// @version v1.8.8
class MyForumPage extends StatelessWidget {
  const MyForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyForumViewModel(model: ForumListModel()),
      child: const MyForumHome(),
    );
  }
}

/// 我的发帖页
///
/// @author zzp
/// @since 2023/10/21
/// @version v1.8.8
class MyForumHome extends StatelessWidget {
  const MyForumHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.create(StringAssets.myForum),
      body: EasyRefresh(
        header: BezierHourGlassHeader(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        footer: BallPulseFooter(color: Theme.of(context).primaryColor),
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 3000), () {
            context.read<MyForumViewModel>().getMyForumList();
          });
        },
        child: ConsumerView<MyForumViewModel>(
          onInit: (viewModel) {
            viewModel.getMyForumList();
          },
          builder: (ctx, viewModel, _) {
            return ForumListView(
                forumList: viewModel.model.forumList,
                forumItemType: ForumItemType.myForum);
          },
        ),
      ),
    );
  }
}
