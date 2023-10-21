import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/forumlist/model/forum_item_image_detail_model.dart';
import 'package:csust_edu_system/common/forumlist/service/forum_item_image_detail_service.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

/// 帖子图片详情ViewModel
///
/// @author zzp
/// @since 2023/10/18
/// @version v1.8.8
class ForumItemImageDetailViewModel extends BaseViewModel<
    ForumItemImageDetailModel, ForumItemImageDetailService> {
  ForumItemImageDetailViewModel({required super.model});

  @override
  ForumItemImageDetailService? createService() => ForumItemImageDetailService();

  /// 设置当前图片下标
  ///
  /// [index] 下标
  void setCurImgIndex(int index) {
    model.curImgIndex = index;
    notifyListeners();
  }

  /// 下载图片
  ///
  /// [imgUrl] 图片链接
  void uploadImage(String imgUrl) {
    service?.uploadImage(
      imgUrl,
      onDataSuccess: (data, msg) async {
        var result = await ImageGallerySaver.saveImage(data, quality: 100);
        if (result[KeyAssets.isSuccess] == true) {
          StringAssets.uploadSuccess.showToast();
        } else {
          (result[KeyAssets.errorMessage] as String).showToast();
        }
      },
    );
  }
}
