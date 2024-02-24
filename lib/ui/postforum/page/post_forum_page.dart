import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/ui/postforum/model/post_forum_model.dart';
import 'package:csust_edu_system/ui/postforum/view/post_forum_anonymous_item.dart';
import 'package:csust_edu_system/ui/postforum/view/post_forum_image_item.dart';
import 'package:csust_edu_system/ui/postforum/view/post_forum_tab_item.dart';
import 'package:csust_edu_system/ui/postforum/viewmodel/post_forum_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 发帖页
///
/// @author zzp
/// @since 2023/10/23
/// @version v1.8.8
class PostForumPage extends StatelessWidget {
  const PostForumPage(
      {super.key, required this.tabList, required this.tabIdList});

  /// 标签列表
  final List<String> tabList;

  /// 标签id列表
  final List<int> tabIdList;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PostForumViewModel(
            model: PostForumModel(tabIdList: tabIdList, tabList: tabList)),
        child: const PostForumHome());
  }
}

/// 发帖页Home
///
/// @author zzp
/// @since 2023/10/23
/// @version v1.8.8
class PostForumHome extends StatelessWidget {
  const PostForumHome({super.key});

  @override
  Widget build(BuildContext context) {
    var postForumViewModel = context.read<PostForumViewModel>();
    return WillPopScope(
      onWillPop: postForumViewModel.isExit,
      child: Scaffold(
        appBar: CommonAppBar.create(
          StringAssets.postForum,
          actions: [
            IconButton(
                onPressed: () {
                  postForumViewModel.postForum();
                },
                icon: const Icon(Icons.done))
          ],
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: TextField(
                controller: postForumViewModel.model.contentController,
                maxLength: 800,
                minLines: 5,
                maxLines: 30,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: StringAssets.saySomething,
                ),
              ),
            ),
            const PostForumTabItem(),
            const PostForumImageItem(),
            const PostForumAnonymousItem(),

          ],
        ),
      ),
    );
  }
}
