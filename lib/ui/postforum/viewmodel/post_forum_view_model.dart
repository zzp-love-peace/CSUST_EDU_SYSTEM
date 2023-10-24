import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ext/list_extension.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/postforum/model/post_forum_model.dart';
import 'package:csust_edu_system/ui/postforum/service/post_forum_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../arch/basedata/page_result_bean.dart';
import '../../../common/dialog/select_dialog.dart';
import '../../../common/forumlist/jsonbean/forum_bean.dart';
import '../../../data/page_result_code.dart';

/// 发帖ViewModel
///
/// @author zzp
/// @since 2023/10/23
/// @version v1.8.8
class PostForumViewModel
    extends BaseViewModel<PostForumModel, PostForumService> {
  PostForumViewModel({required super.model});

  /// 上一次发帖时间
  DateTime? _lastPostTime;

  /// 设置是否匿名
  ///
  /// [isAnonymous] 是否匿名
  void setIsAnonymous(bool isAnonymous) {
    model.isAnonymous = isAnonymous;
    notifyListeners();
  }

  /// 添加图片路径在列表头
  ///
  /// [imgPath] 图片路径
  void insertImgPathAtFirst(String imgPath) {
    model.imgPaths = model.imgPaths.insertCanNotify(imgPath, 0);
    notifyListeners();
  }

  /// 删除图片路径
  ///
  /// [imgPath] 图片路径
  void removeImgPath(String imgPath) {
    model.imgPaths = model.imgPaths.removeCanNotify(imgPath);
    notifyListeners();
  }

  /// 展示标签选择器
  void showTabPicker() {
    model.tabPicker.showPicker(
      context,
      title: StringAssets.selectTab,
      pickerData: model.tabList,
      onConfirm: (value, index) {
        model.tab = value;
        notifyListeners();
      },
    );
  }

  /// 发帖
  void postForum() async {
    if (_lastPostTime == null ||
        DateTime.now().difference(_lastPostTime!) >
            const Duration(milliseconds: 2000)) {
      _lastPostTime = DateTime.now();
      if (model.tab.isNotEmpty) {
        var tabId = model.tabIdList[model.tabList.indexOf(model.tab)];
        var content = model.contentController.text;
        if (content.isNotBlank()) {
          SmartDialog.showLoading(msg: StringAssets.uploading);
          List<MultipartFile> images = [];
          for (var imgPath in model.imgPaths) {
            if (imgPath.isNotEmpty) {
              images.add(await MultipartFile.fromFile(imgPath));
            }
          }
          service?.postForum(
              themeId: tabId,
              content: content,
              isAnonymous: model.isAnonymous,
              images: images,
              onDataSuccess: (data, msg) {
                var forum = ForumBean.fromJson(data);
                StringAssets.uploadSuccess.showToast();
                context.pop(
                    result: PageResultBean(PageResultCode.uploadForumSuccess,
                        (forum: forum, tabId: tabId)));
              },
              onFinish: (_) {
                SmartDialog.dismiss();
              });
        } else {
          StringAssets.tabCannotEmpty.showToast();
        }
      } else {
        StringAssets.contentCannotEmpty.showToast();
      }
    }
  }

  /// 是否要退出
  Future<bool> isExit() {
    if (model.contentController.text.isNotEmpty || model.imgPaths.length > 1) {
      SelectDialog(
        title: StringAssets.tips,
        subTitle: StringAssets.postForumTips,
        okCallback: () {
          context.pop();
        },
      ).showDialog();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  PostForumService? createService() => PostForumService();
}
