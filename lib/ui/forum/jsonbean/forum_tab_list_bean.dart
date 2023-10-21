import 'package:csust_edu_system/ass/key_assets.dart';

import '../../../common/forumlist/jsonbean/forum_bean.dart';

/// 标签帖子列表Bean类
///
/// @author zzp
/// @since 2023/10/19
/// @version v1.8.8
class ForumTabListBean {
  ForumTabListBean.fromJson(Map<String, dynamic> json)
      : totalCount = json[KeyAssets.totalCount],
        forumList = (json[KeyAssets.indexPosts] as List)
            .map((e) => ForumBean.fromJson(e))
            .toList();

  /// 总数量
  int totalCount;

  /// 帖子列表
  List<ForumBean> forumList;
}
