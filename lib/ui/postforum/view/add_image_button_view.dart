import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// 添加图片按钮
///
/// @author zzp
/// @since 2023/10/23
/// @version v1.8.8
class AddImageButtonView extends StatelessWidget {
  AddImageButtonView({Key? key, required this.addImageCallback})
      : super(key: key);

  /// 添加图片回调
  final Function(String) addImageCallback;

  /// 图片选择器
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context);
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 48) / 3,
        color: Colors.grey.withOpacity(0.3),
        child: const Center(
          child: Icon(
            Icons.add_photo_alternate_outlined,
            color: Colors.black54,
            size: 36,
          ),
        ),
      ),
    );
  }

  _showBottomSheet(context) {
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
              InkWell(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Text(
                      StringAssets.takePhoto,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
                onTap: () async {
                  final XFile? image = await _picker.pickImage(
                      source: ImageSource.camera, imageQuality: 70);
                  if (image != null) {
                    addImageCallback(image.path);
                  }
                  context.pop();
                },
              ),
              InkWell(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Text(
                      StringAssets.selectFromPhotoAlbum,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
                onTap: () async {
                  final XFile? image = await _picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 70);
                  if (image != null) {
                    addImageCallback(image.path);
                  }
                  context.pop();
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                thickness: 1,
              ),
              InkWell(
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Text(
                      StringAssets.cancel,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
                onTap: () {
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
