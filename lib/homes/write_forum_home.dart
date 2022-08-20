import 'dart:io';

import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/network/network.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:csust_edu_system/widgets/hint_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../route/fade_route.dart';
import '../widgets/select_dialog.dart';

class WriteForumHome extends StatefulWidget {
  final List<String> tabs;
  final List<int> tabsId;
  // final Function callback;

  const WriteForumHome({Key? key, required this.tabs, required this.tabsId})
      : super(key: key);

  @override
  State<WriteForumHome> createState() => _WriteForumHomeState();
}

class _WriteForumHomeState extends State<WriteForumHome> {
  String _tab = '';
  List<int> _pickerIndex = [0];

  List<Widget> _imgList = [];
  final List<String> _imgPaths = [];

  bool _isAnonymous = false;

  final _contentController = TextEditingController();

  DateTime? _lastTime;

  @override
  void initState() {
    super.initState();
    _imgList.add(_AddImgButton(
      callback: _imgButtonCallback,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "发帖",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  if (_lastTime == null ||
                      DateTime.now().difference(_lastTime!) >
                          const Duration(milliseconds: 2000)) {
                    _lastTime = DateTime.now();
                    _postForum();
                  }
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
                controller: _contentController,
                maxLength: 800,
                minLines: 5,
                maxLines: 30,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '说点啥...',
                ),
              ),
            ),
            Card(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                color: Colors.white,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: InkWell(
                  onTap: () {
                    Picker(
                        title: const Text(
                          '选择标签',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        confirmText: '确定',
                        cancelText: '取消',
                        selecteds: _pickerIndex,
                        adapter:
                            PickerDataAdapter<String>(pickerdata: widget.tabs),
                        changeToFirst: true,
                        hideHeader: false,
                        onConfirm: (Picker picker, List value) {
                          setState(() {
                            var tabString = picker.adapter.text
                                .substring(1, picker.adapter.text.length - 1);
                            _tab = tabString;
                            _pickerIndex = [value[0]];
                          });
                        }).showModal(context);
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                        child: Image.asset(
                          'assets/images/tab.png',
                          width: 20,
                          height: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const Text(
                        '标签',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        _tab,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.navigate_next),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                )),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                    height: ((MediaQuery.of(context).size.width - 48) / 3) + 24,
                    margin: const EdgeInsets.all(12),
                    // padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: GridView.count(
                        reverse: true,
                        crossAxisSpacing: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        children: _imgList,
                      ),
                    )),
                if (_imgList.length == 1)
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2.1),
                    child: Wrap(
                      direction: Axis.vertical,
                      children: const [
                        Text(
                          '最多上传3张图片',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          '请勿上传违规图片！',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          '否则将被禁言并通报',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                    child: Icon(
                      _isAnonymous ? Icons.visibility_off : Icons.visibility,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                  ),
                  const Text(
                    '匿名发布',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const Spacer(),
                  Switch(
                      value: _isAnonymous,
                      onChanged: (value) {
                        setState(() {
                          _isAnonymous = value;
                        });
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onWillPop: _isExit,
    );
  }

  Future<bool> _isExit() {
    if (_contentController.text.isNotEmpty || _imgPaths.isNotEmpty) {
      SmartDialog.compatible.show(
          widget: SelectDialog(
            title: '提示',
            subTitle: '已有编辑的内容存在，确定要退出吗？',
            callback: () {
              Navigator.pop(context);
            },
          ),
          clickBgDismissTemp: false);
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  _imgButtonCallback(String path) {
    _imgPaths.insert(0, path);
    _imgList = _imgList.reversed.toList();
    _imgList.add(_imgView(path));
    setState(() {
      _imgList = _imgList.reversed.toList();
    });
  }

  _imgView(String path) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(FadeRoute(
            page: PhotoViewGallery.builder(
              pageController: PageController(initialPage: _imgPaths.indexOf(path)),
              itemCount: _imgPaths.length,
              builder: (BuildContext context,int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: FileImage(File(_imgPaths[index])),
                  // initialScale: PhotoViewComputedScale.contained *
                  //     0.95,
                );
              },)));
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Image.file(
            File(path),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          GestureDetector(
            onTap: () {
              _imgList.removeAt(_imgPaths.indexOf(path));
              _imgPaths.remove(path);
              _imgList = _imgList.reversed.toList();
              setState(() {
                _imgList = _imgList.reversed.toList();
              });
            },
            child: Container(
              width: 24,
              height: 24,
              color: Colors.black54,
              child: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  _postForum() async {
    if (_tab.isEmpty) {
      SmartDialog.compatible.showToast('', widget: const CustomToast('标签不能为空'));
      return;
    }
    var themeId = widget.tabsId[widget.tabs.indexOf(_tab)];
    var content = _contentController.text;
    if (content.isEmpty) {
      SmartDialog.compatible.showToast('', widget: const CustomToast('内容不能为空'));
      return;
    }
    SmartDialog.showLoading(msg: '上传中...');
    // print("themeId: $themeId === content: $content");
    List<MultipartFile> images = [];
    for (var imgPath in _imgPaths) {
      images.add(await MultipartFile.fromFile(imgPath));
    }
    HttpManager()
        .postForum(StuInfo.token, themeId, content, _isAnonymous, images)
        .then((value) {
      if (value.isNotEmpty) {
        SmartDialog.dismiss();
        if (value['code'] == 200) {
          SmartDialog.compatible.showToast('', widget: const CustomToast('上传成功'));
          Navigator.of(context).pop();
        } else if(value['code']== 701) {
          SmartDialog.compatible.show(widget: HintDialog(title: '提示', subTitle: value['msg']), clickBgDismissTemp: false);
        } else {
          SmartDialog.compatible.showToast('', widget: CustomToast(value['msg']));
        }
      } else {
        SmartDialog.dismiss();
        SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了'));
      }
    }, onError: (_) {
      SmartDialog.dismiss();
      SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了'));
    });
  }
}

class _AddImgButton extends StatelessWidget {
  _AddImgButton({Key? key, required this.callback}) : super(key: key);

  final Function(String) callback;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _showBottomSheet(context);
        },
        child: Container(
          color: Colors.grey.withOpacity(0.3),
          child: const Center(
            child: Icon(
              Icons.add_photo_alternate_outlined,
              color: Colors.black54,
              size: 36,
            ),
          ),
        ));
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
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              '拍照',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ))),
                    onTap: () async {
                      final XFile? image = await _picker.pickImage(
                          source: ImageSource.camera, imageQuality: 70);
                      if (image != null) {
                        callback(image.path);
                      }
                      Navigator.pop(context);
                    },
                  ),
                  InkWell(
                    child: const Center(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              '从相册选取',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ))),
                    onTap: () async {
                      final XFile? image = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 70);
                      if (image != null) {
                        callback(image.path);
                      }
                      Navigator.pop(context);
                    },
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    thickness: 1,
                  ),
                  InkWell(
                    child: const Center(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              '取消',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ))),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
        });
  }
}
