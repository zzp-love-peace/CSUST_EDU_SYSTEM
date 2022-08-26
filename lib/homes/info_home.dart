import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/utils/my_util.dart';
import 'package:csust_edu_system/widgets/edit_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';

import '../network/network.dart';
import '../utils/grade_util.dart';
import '../widgets/custom_toast.dart';

late String _avatar;

String _imagePath = "";

class InfoHome extends StatefulWidget {
  const InfoHome({Key? key}) : super(key: key);

  @override
  State<InfoHome> createState() => _InfoHomeState();
}

class _InfoHomeState extends State<InfoHome> {
  late bool _sex;
  late String _username;
  late String _name;
  late String _major;
  late String _college;
  late String _className;

  late String _stuId;
  late List<int> _pickerIndex;
  double _allPoint = 0;

  bool _enable = false;

  @override
  void initState() {
    super.initState();
    _initData();
    _setAllPoint();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text(
          "个人资料",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _enable = false;
                });
                _refreshStuInfo();
                _setAllPoint();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            _HeadImageRow(
              callback: _checkEnable,
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '昵称',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  _username,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              onTap: () {
                SmartDialog.compatible.show(
                    widget: EditDialog(
                        title: '提示',
                        subTitle: '请输入您要修改的昵称',
                        callback: (value) {
                          setState(() {
                            _username = value;
                            _checkEnable();
                          });
                        }), clickBgDismissTemp: false);
              },
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '性别',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  _sex ? "男" : "女",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              onTap: () {
                Picker(
                    title: const Text(
                      '选择性别',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    confirmText: '确定',
                    cancelText: '取消',
                    selecteds: _pickerIndex,
                    adapter: PickerDataAdapter<String>(pickerdata: ['男', '女']),
                    changeToFirst: true,
                    hideHeader: false,
                    onConfirm: (Picker picker, List value) {
                      setState(() {
                        var result = picker.adapter.text
                            .substring(1, picker.adapter.text.length - 1);
                        _pickerIndex = result == '男' ? [0] : [1];
                        _sex = result == '男';
                        _checkEnable();
                      });
                    }).showModal(context);
              },
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '姓名',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  _name,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '学号',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  _stuId,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '学院',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  _college,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '专业',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  _major,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '班级',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  _className,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '总绩点',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  _allPoint.toStringAsFixed(2),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 20, 50, 30),
              child: ElevatedButton(
                child: const Center(
                  child: Text(
                    "保存",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                style: ButtonStyle(
                  enableFeedback: _enable,
                  backgroundColor: MaterialStateProperty.all(
                      _enable ? Theme.of(context).primaryColor : Colors.grey),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.fromLTRB(0, 10, 0, 10)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
                ),
                onPressed: () {
                  if (_enable) {
                    _changeStuInfo(_imagePath);
                  }
                },
              ),
            )
          ],
        ).toList(),
        // children:
      ),
    );
  }

  _changeStuInfo(String imgPath) {
    if (imgPath.isNotEmpty) {
      SmartDialog.showLoading(msg: '上传中');
      HttpManager().setHeadImg(StuInfo.token, imgPath).then((value) {
        if (value.isNotEmpty) {
          // print(value);
          SmartDialog.dismiss();
          if (value['code'] == 200) {
            if (_sex != StuInfo.sex || _username != StuInfo.username) {
              HttpManager().setStuInfo(StuInfo.token, _username, _sex).then(
                  (value) {
                if (value.isNotEmpty) {
                  if (value['code'] == 200) {
                    _refreshStuInfo();
                    setState(() {
                      _enable = false;
                    });
                    SmartDialog.compatible
                        .showToast('', widget: const CustomToast('保存成功'));
                  } else {
                    SmartDialog.compatible
                        .showToast('', widget: CustomToast(value['msg']));
                  }
                }
              }, onError: (_) {
                SmartDialog.compatible
                    .showToast('', widget: const CustomToast('服务器异常，修改信息失败'));
              });
            }
          } else {
            SmartDialog.compatible
                .showToast('', widget: CustomToast(value['msg']));
          }
        }
      }, onError: (_) {
        SmartDialog.compatible
            .showToast('', widget: const CustomToast('服务器异常，上传头像失败'));
      });
    } else {
      if (_sex != StuInfo.sex || _username != StuInfo.username) {
        print(_sex);
        HttpManager().setStuInfo(StuInfo.token, _username, _sex).then((value) {
          if (value.isNotEmpty) {
            if (value['code'] == 200) {
              _refreshStuInfo();
              setState(() {
                _enable = false;
              });
              SmartDialog.compatible
                  .showToast('', widget: const CustomToast('保存成功'));
            } else {
              SmartDialog.compatible
                  .showToast('', widget: CustomToast(value['msg']));
            }
          }
        }, onError: (_) {
          SmartDialog.compatible
              .showToast('', widget: const CustomToast('服务器异常，修改信息失败'));
        });
      }
    }
  }

  _initData() {
    _sex = StuInfo.sex;
    _username = StuInfo.username;
    _avatar = StuInfo.avatar;
    print("_avatar is " + _avatar);
    _name = StuInfo.name;
    _major = StuInfo.major;
    _college = StuInfo.college;
    _className = StuInfo.className;
    _stuId = StuInfo.stuId;
    _pickerIndex = StuInfo.sex ? [0] : [1];
  }

  _setAllPoint() async {
    var value =
        await HttpManager().getAllSemester(StuInfo.cookie, StuInfo.token);
    if (value.isNotEmpty) {
      if (value['code'] == 200) {
        List gradeList = [];
        List allTerm = value['data'];
        bool isError = false;
        for (int i=0; i<allTerm.length; i++) {
          var scoreValue = await HttpManager()
              .queryScore(StuInfo.token, StuInfo.cookie, allTerm[i]);
          if (scoreValue['code'] == 200) {
            List grade = scoreValue['data'];
            gradeList.addAll(grade);
          } else {
            if (i != allTerm.length -1) {
              isError = true;
            }
            if (kDebugMode) {
              print('获取${allTerm[i]}成绩出错了');
            }
          }
        }
        if (kDebugMode) {
          print(gradeList);
        }
        if (mounted) {
          if (StuInfo.name.isNotEmpty && !isError) {
            setState(() {
              _allPoint = getSumPoint(gradeList);
            });
          }
        }
      } else {
        if (kDebugMode) {
          print('获取所有学期出错了');
        }
      }
    }
  }

  _refreshStuInfo() {
    HttpManager().refreshStuInfo(StuInfo.cookie, StuInfo.token).then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          print(value);
          StuInfo.initData(value['data']);
          setState(() {
            _initData();
          });
        } else {
          SmartDialog.compatible
              .showToast('', widget: CustomToast(value['msg']));
        }
      }
    }, onError: (_) {
      SmartDialog.compatible
          .showToast('', widget: const CustomToast('刷新个人信息出错了'));
    });
  }

  _checkEnable() {
    setState(() {
      if (_username == StuInfo.username &&
          _imagePath.isEmpty &&
          _sex == StuInfo.sex) {
        _enable = false;
      } else {
        _enable = true;
      }
    });
  }
}

class _HeadImageRow extends StatefulWidget {
  final Function callback;

  const _HeadImageRow({Key? key, required this.callback}) : super(key: key);

  @override
  State<_HeadImageRow> createState() => _HeadImageRowState();
}

class _HeadImageRowState extends State<_HeadImageRow> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Text(
              '头像',
              style: TextStyle(color: Colors.black),
            ),
          ),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 35, 15),
              child: ClipOval(
                  child: _imagePath.isEmpty
                      ? CachedNetworkImage(
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          imageUrl: addPrefixToUrl(_avatar),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                              )))
                      : Image.file(File(_imagePath),
                          width: 60, height: 60, fit: BoxFit.cover)))
        ],
      ),
      onTap: () {
        _changeHeadImage();
      },
    );
  }

  _changeHeadImage() {
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    showModalBottomSheet(
        context: context,
        // elevation: 10,
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
                        setState(() {
                          _imagePath = image.path;
                        });
                      }
                      Navigator.pop(context);
                      widget.callback();
                    },
                  ),
                  InkWell(
                    child: const Center(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                            child: Text(
                              '从相册选取',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ))),
                    onTap: () async {
                      final XFile? image = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 70);
                      if (image != null) {
                        setState(() {
                          _imagePath = image.path;
                        });
                      }
                      Navigator.pop(context);
                      widget.callback();
                    },
                  ),
                  InkWell(
                    child: const Center(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                            child: Text(
                              '恢复默认头像',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ))),
                    onTap: () {
                      HttpManager()
                          .restoreHeadImg(StuInfo.cookie, StuInfo.token)
                          .then((value) {
                        if (value.isNotEmpty) {
                          if (value['code'] == 200) {
                            SmartDialog.compatible.showToast('',
                                widget: const CustomToast('恢复成功，刷新后生效'));
                          } else {
                            SmartDialog.compatible.showToast('',
                                widget: CustomToast(value['msg']));
                          }
                        } else {
                          SmartDialog.compatible.showToast('',
                              widget: const CustomToast('出现异常了'));
                        }
                      }, onError: (_) {
                        SmartDialog.compatible
                            .showToast('', widget: const CustomToast('出现异常了'));
                      });
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
                              '取消',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ))),
                    onTap: () {
                      Navigator.pop(context);
                      widget.callback();
                    },
                  ),
                ],
              ));
        });
  }
}
