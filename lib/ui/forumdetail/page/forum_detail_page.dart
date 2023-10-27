import 'package:csust_edu_system/arch/basedata/page_result_bean.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/common/cachedimage/data/cached_image_type.dart';
import 'package:csust_edu_system/common/cachedimage/view/cached_image.dart';
import 'package:csust_edu_system/common/forumlist/view/forum_image_view.dart';
import 'package:csust_edu_system/data/page_result_code.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/forumdetail/model/forum_detail_model.dart';
import 'package:csust_edu_system/ui/forumdetail/view/comment_list_view.dart';
import 'package:csust_edu_system/ui/forumdetail/viewmodel/forum_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

import '../../../common/dialog/select_dialog.dart';
import '../../../common/forumlist/jsonbean/forum_bean.dart';
import '../../../data/stu_info.dart';
import '../../../util/date_util.dart';
import '../view/forum_detail_bottom_comment_view.dart';
import '../view/forum_detail_like_and_comment_view.dart';

/// 帖子详情页
///
/// @author zzp
/// @since 2023/10/23
/// @version v1.8.8
class ForumDetailPage extends StatelessWidget {
  const ForumDetailPage({super.key, required this.forumBean});

  /// 帖子
  final ForumBean forumBean;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ForumDetailViewModel(model: ForumDetailModel(forumBean: forumBean)),
      child: const ForumDetailHome(),
    );
  }
}

/// 帖子详情Home
///
/// @author zzp
/// @since 2023/10/23
/// @version v1.8.8
class ForumDetailHome extends StatelessWidget {
  const ForumDetailHome({super.key});

  @override
  Widget build(BuildContext context) {
    var forumDetailViewModel = context.readViewModel<ForumDetailViewModel>();
    var forumDetailModel = forumDetailViewModel.model;
    return WillPopScope(
      child: Scaffold(
        appBar: CommonAppBar.create(
          StringAssets.detail,
          actions: [
            forumDetailModel.forumBean.userInfo.userId == StuInfo.id
                ? IconButton(
                    onPressed: () {
                      SelectDialog(
                        title: StringAssets.tips,
                        subTitle: StringAssets.deleteForumTips,
                        okCallback: () {
                          forumDetailViewModel.deleteForum();
                        },
                      ).showDialog();
                    },
                    icon: const Icon(Icons.delete),
                  )
                : IconButton(
                    onPressed: () {
                      SelectDialog(
                        title: StringAssets.tips,
                        subTitle: StringAssets.reportForumTips,
                        okCallback: () {
                          forumDetailViewModel.reportForum();
                        },
                      ).showDialog();
                    },
                    icon: const Icon(Icons.warning),
                  ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: EasyRefresh(
                header: MaterialHeader(),
                onRefresh: () async {
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    forumDetailViewModel.getForumDetail();
                  });
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Hero(
                          tag: forumDetailModel.forumBean.userInfo.avatar +
                              forumDetailModel.forumBean.id.toString(),
                          child: _headImageView(
                              forumDetailModel.forumBean.userInfo.avatar)),
                      Hero(
                        tag: forumDetailModel.forumBean.realInfo.name +
                            forumDetailModel.forumBean.id.toString(),
                        child: Text(
                          forumDetailModel.forumBean.realInfo.name.hideName(),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                          child: Hero(
                            tag: forumDetailModel.forumBean.content +
                                forumDetailModel.forumBean.id.toString(),
                            child: SelectableText(
                              forumDetailModel.forumBean.content,
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      if (forumDetailModel.forumBean.images.isNotEmpty)
                        SizedBox(
                          height:
                              ((MediaQuery.of(context).size.width - 24) / 3) +
                                  6,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                            child: GridView.count(
                              reverse: true,
                              crossAxisSpacing: 3,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              children: forumDetailModel.forumBean.images
                                  .map((url) => ForumImageView(
                                      url: url,
                                      images:
                                          forumDetailModel.forumBean.images))
                                  .toList(),
                            ),
                          ),
                        ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: Hero(
                              tag: forumDetailModel.forumBean.createTime +
                                  forumDetailModel.forumBean.id.toString(),
                              child: Text(
                                DateUtil.getForumDateString(
                                    forumDetailModel.forumBean.createTime),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const ForumDetailLikeAndCommentView(),
                      const CommentListView(),
                    ],
                  ),
                ),
              ),
            ),
            const ForumDetailBottomCommentView(),
          ],
        ),
      ),
      onWillPop: () {
        context.pop<ForumBean>(
            result: PageResultBean(
                PageResultCode.forumStateChange, forumDetailModel.forumBean));
        return Future.value(false);
      },
    );
  }

  /// 头像
  Widget _headImageView(String imgUrl) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 8),
      child: Container(
        width: 64,
        height: 64,
        child: ClipOval(
          child: CachedImage(
            url: imgUrl,
            size: 64,
            type: CachedImageType.webp,
            fit: BoxFit.cover,
            isShowDetail: true,
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
