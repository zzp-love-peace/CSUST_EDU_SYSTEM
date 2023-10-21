import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/common/forumlist/model/forum_list_model.dart';
import 'package:csust_edu_system/common/forumlist/view/forum_list_view.dart';
import 'package:csust_edu_system/ui/mycollect/viewmodel/my_collect_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

import '../../../common/forumlist/data/forum_item_type.dart';

/// 我的收藏页
///
/// @author zzp
/// @since 2023/10/21
/// @version v1.8.8
class MyCollectPage extends StatelessWidget {
  const MyCollectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyCollectViewModel(model: ForumListModel()),
      child: const MyCollectHome(),
    );
  }
}

/// 我的收藏页Home
///
/// @author zzp
/// @since 2023/10/21
/// @version v1.8.8
class MyCollectHome extends StatelessWidget {
  const MyCollectHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.create(StringAssets.myCollect),
      body: EasyRefresh(
        header: DeliveryHeader(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        onRefresh: () async {
          await Future.delayed(
            const Duration(milliseconds: 2000),
            () {
              context.read<MyCollectViewModel>().getMyCollectList();
            },
          );
        },
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              margin: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.white),
              child: const Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      StringAssets.myCollectTips,
                    ),
                  )
                ],
              ),
            ),
            ConsumerView<MyCollectViewModel>(
              onInit: (viewModel) {
                viewModel.getMyCollectList();
              },
              builder: (ctx, viewModel, _) {
                return ForumListView(
                    forumList: viewModel.model.forumList,
                    forumItemType: ForumItemType.collectForum);
              },
            )
          ],
        ),
      ),
    );
  }
}
