import 'dart:io';

import 'package:csust_edu_system/arch/baseview/seletor_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/stuinfo/viewmodel/stu_info_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../common/cachedimage/data/cached_image_type.dart';
import '../../../common/cachedimage/view/cached_image.dart';
import '../../../data/stu_info.dart';

/// 个人资料头像View
///
/// @author wk
/// @since 2023/11/26
/// @version v1.8.8
class HeadImgRow extends StatelessWidget {
  const HeadImgRow({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Text(
              StringAssets.headImg,
              style: TextStyle(color: Colors.black),
            ),
          ),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 35, 15),
              child: SelectorView<StuInfoViewModel, String>(
                  selector: (ctx, viewModel) => viewModel.model.imagePath,
                  builder: (ctx, imagePath, _) {
                    return ClipOval(
                        child: imagePath.isEmpty ||
                                imagePath == StringAssets.restoreHeadImg
                            ? CachedImage(
                                url: StuInfo.avatar,
                                size: 60,
                                fit: BoxFit.cover,
                                type: CachedImageType.webp,
                              )
                            : Image.file(File(imagePath),
                                width: 60, height: 60, fit: BoxFit.cover));
                  }))
        ],
      ),
      onTap: () {
        _changeHeadImage(context);
      },
    );
  }

  /// 展示头像BottomSheet
  ///
  /// [context] BuildContext
  _changeHeadImage(BuildContext context) {
    StuInfoViewModel stuInfoViewModel =
        context.readViewModel<StuInfoViewModel>();
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        ),
        builder: (context) {
          return Container(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  sheetItem(
                      text: StringAssets.takePhoto,
                      callBack: stuInfoViewModel.getImgByCamera),
                  sheetItem(
                      text: StringAssets.selectFromPhotoAlbum,
                      callBack: stuInfoViewModel.getImgByGallery),
                  sheetItem(
                      text: StringAssets.restoreHeadImg,
                      callBack: () {
                        stuInfoViewModel.restoreHeadImg(StuInfo.cookie);
                      }),
                  Divider(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    thickness: 1,
                  ),
                  sheetItem(text: StringAssets.cancel, callBack: context.pop),
                ],
              ));
        });
  }

  /// bottomSheetItem
  ///
  /// [text] sheet的文字提示
  /// [callBack] 点击回调
  Widget sheetItem({required String text, required Function callBack}) {
    return InkWell(
      child: Center(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
              child: Text(
                text,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ))),
      onTap: () {
        callBack.call();
      },
    );
  }
}
