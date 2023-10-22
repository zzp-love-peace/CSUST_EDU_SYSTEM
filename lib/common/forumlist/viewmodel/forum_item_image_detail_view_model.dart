import 'package:csust_edu_system/common/cachedimage/viewmodel/cached_image_view_model.dart';
import 'package:csust_edu_system/common/forumlist/model/forum_item_image_detail_model.dart';

/// 帖子图片详情ViewModel
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class ForumItemImageDetailViewModel
    extends CachedImageViewModel<ForumItemImageDetailModel> {
  ForumItemImageDetailViewModel({required super.model});

  /// 设置当前图片下标
  ///
  /// [index] 下标
  void setCurImgIndex(int index) {
    model.curImgIndex = index;
    notifyListeners();
  }
}
