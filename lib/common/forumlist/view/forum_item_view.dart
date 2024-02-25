import 'package:csust_edu_system/common/cachedimage/data/cached_image_type.dart';
import 'package:csust_edu_system/common/cachedimage/view/cached_image.dart';
import 'package:csust_edu_system/common/forumlist/data/forum_item_type.dart';
import 'package:csust_edu_system/common/forumlist/jsonbean/forum_bean.dart';
import 'package:csust_edu_system/common/forumlist/model/forum_item_model.dart';
import 'package:csust_edu_system/common/forumlist/view/forum_control_view.dart';
import 'package:csust_edu_system/common/forumlist/view/forum_image_view.dart';
import 'package:csust_edu_system/common/forumlist/viewmodel/forum_item_view_model.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui/forum/viewmodel/forum_tab_list_view_model.dart';
import '../../../ui/mycollect/viewmodel/my_collect_view_model.dart';
import '../../../ui/myforum/viewmodel/my_forum_view_model.dart';

/// 帖子Item View
///
/// @author zzp
/// @since 2023/9/28
/// @version v1.8.8
class ForumItemView extends StatelessWidget {
  const ForumItemView({super.key, required this.forum, required this.type});

  /// 帖子类型
  final ForumItemType type;

  /// 帖子
  final ForumBean forum;

  @override
  Widget build(BuildContext context) {
    var forumControlViewModel =
        ForumItemViewModel(model: ForumItemModel(type: type, forumBean: forum));
    var child = Builder(
      builder: (innerContext) {
        var viewModel = innerContext.readViewModel<ForumItemViewModel>();
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(12, 3, 12, 8),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Ink(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              onTap: () {
                viewModel.navigatorToDetailHome();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Hero(
                          tag: forum.userInfo.avatar +
                              forum.id.toString() +
                              forumItemTypeToHeroTag(type),
                          child: ClipOval(
                            child: CachedImage(
                              size: 42,
                              url: forum.userInfo.avatar,
                              type: CachedImageType.thumb,
                              fit: BoxFit.cover,
                              isShowDetail: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: forum.userInfo.username +
                                forum.id.toString() +
                                forumItemTypeToHeroTag(type),
                            child: Text(
                              forum.userInfo.username,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Hero(
                            tag: forum.createTime +
                                forum.id.toString() +
                                forumItemTypeToHeroTag(type),
                            child: Text(
                              DateUtil.getForumDateString(forum.createTime),
                              style: const TextStyle(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Hero(
                      tag: forum.content +
                          forum.id.toString() +
                          forumItemTypeToHeroTag(type),
                      child: Text(
                        forum.content,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                  if (forum.images.isNotEmpty)
                    SizedBox(
                      height: ((MediaQuery.of(context).size.width - 24) / 3),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: GridView.count(
                          reverse: true,
                          crossAxisSpacing: 3,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          children: forum.images
                              .map((url) => ForumImageView(
                              url: url, images: forum.images))
                              .toList(),
                        ),
                      ),
                    ),
                  const ForumControlView()
                ],
              ),
            ),
          ),
        );
      },
    );
    switch (type) {
      case ForumItemType.tabForum:
        return ChangeNotifierProxyProvider<ForumTabListViewModel,
                ForumItemViewModel>(
            create: (_) => forumControlViewModel,
            update: (context, forumTabListViewModel, _) =>
                forumControlViewModel,
            child: child);
      case ForumItemType.collectForum:
        return ChangeNotifierProxyProvider<MyCollectViewModel,
                ForumItemViewModel>(
            create: (_) => forumControlViewModel,
            update: (context, forumTabListViewModel, _) =>
                forumControlViewModel,
            child: child);
      case ForumItemType.myForum:
        return ChangeNotifierProxyProvider<MyForumViewModel,
                ForumItemViewModel>(
            create: (_) => forumControlViewModel,
            update: (context, forumTabListViewModel, _) =>
                forumControlViewModel,
            child: child);
    }
  }
}
