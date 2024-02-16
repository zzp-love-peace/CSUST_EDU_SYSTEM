import 'dart:convert';

import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/data/date_info.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/stuinfo/model/stu_info_model.dart';
import 'package:csust_edu_system/ui/stuinfo/service/stu_info_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_picker/image_picker.dart';

import '../../../ass/key_assets.dart';
import '../../../common/dialog/edit_dialog.dart';
import '../../../data/stu_info.dart';
import '../../../util/grade_util.dart';
import '../../../util/sp/sp_data.dart';
import '../../../util/sp/sp_util.dart';
import '../../grade/db/grade_db_manager.dart';
import '../../grade/json/grade_bean.dart';

/// 个人资料viewModel
///
/// @author wk
/// @since 2023/11/26
/// @version v1.8.8
class StuInfoViewModel extends BaseViewModel<StuInfoModel, StuInfoService> {
  StuInfoViewModel({required super.model});

  /// 图片选择器(文件操作)
  final ImagePicker _picker = ImagePicker();

  /// 上一次click触发时间
  int lastClick = 0;

  @override
  StuInfoService? createService() => StuInfoService();

  /// 刷新个人资料
  ///
  /// [cookie] cookie
  void refreshStuInfo(String cookie) {
    var now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastClick < 1500) return;
    lastClick = now;
    service?.refreshStuInfo(
        cookie: cookie,
        onDataSuccess: (data, msg) {
          StuInfo.initData(data);
          model.userName = StuInfo.username;
          model.sex = StuInfo.sex;
          model.imagePath = StringAssets.emptyStr;
          model.enable = false;
          model.avatar = StuInfo.avatar;
          notifyListeners();
          StringAssets.refreshSuccess.showToast();
        });
  }

  /// 设置个人资料
  ///
  /// [userName] 昵称
  /// [sex] 性别
  void setStuInfo(String userName, bool sex) {
    service?.setStuInfo(
        userName: userName,
        sex: sex,
        onDataSuccess: (data, msg) {
          StuInfo.username = userName;
          StuInfo.sex = sex;
          refreshStuInfo(StuInfo.cookie);
        });
  }

  /// 设置头像
  ///
  /// [imgPath] 图片路径
  void setHeadImg(String imgPath) {
    SmartDialog.showLoading(msg: StringAssets.uploading);
    service?.setHeadImg(
        imgPath: imgPath,
        onDataSuccess: (data, msg) {
          refreshStuInfo(StuInfo.cookie);
        },
        onFinish: (_) {
          SmartDialog.dismiss();
        });
  }

  /// 恢复默认头像
  ///
  /// [cookie] cookie
  void restoreHeadImg(String cookie) {
    service?.restoreHeadImg(
        cookie: cookie,
        onDataSuccess: (data, msg) {
          StuInfo.avatar = data;
          model.avatar = data;
          model.imagePath = StringAssets.restoreHeadImg;
          StringAssets.refreshSuccess.showToast();
          notifyListeners();
        });
    context.pop();
  }

  /// 拍照获取头像
  void getImgByCamera() {
    _picker
        .pickImage(source: ImageSource.camera, imageQuality: 70)
        .then((image) {
      if (image != null) {
        model.imagePath = image.path;
        model.enable = true;
        notifyListeners();
      }
    });
    context.pop();
  }

  /// 从相册获取头像
  void getImgByGallery() {
    _picker
        .pickImage(source: ImageSource.gallery, imageQuality: 70)
        .then((image) {
      if (image != null) {
        model.imagePath = image.path;
        model.enable = true;
        notifyListeners();
      }
    });
    context.pop();
  }

  /// 修改昵称
  void changeUserName() {
    EditDialog(
        title: StringAssets.tips,
        subTitle: StringAssets.pleaseInputChangedUsername,
        callback: (value) {
          model.userName = value;
          model.enable = true;
          if (!(model.sex != StuInfo.sex ||
              model.userName != StuInfo.username ||
              model.imagePath.isNotEmpty)) {
            model.enable = false;
          }
          notifyListeners();
        }).showDialog();
  }

  /// 选择性别
  void selectSex() {
    model.sexPicker.showPicker(
      context,
      title: StringAssets.selectSex,
      initIndex: model.pickerIndex,
      pickerData: model.sexList,
      onConfirm: (sex, index) {
        model.sex = sex == StringAssets.man;
        model.pickerIndex = sex == StringAssets.man ? 0 : 1;
        model.enable = true;
        if (!(model.sex != StuInfo.sex ||
            model.userName != StuInfo.username ||
            model.imagePath.isNotEmpty)) {
          model.enable = false;
        }
        notifyListeners();
      },
    );
  }

  /// 保存修改个人资料
  void changeStuInfo() {
    if (model.imagePath.isNotEmpty) {
      setHeadImg(model.imagePath);
    }
    if (model.userName != StuInfo.username || model.sex != StuInfo.sex) {
      setStuInfo(model.userName, model.sex);
    }
    model.enable = false;
    notifyListeners();
  }

  /// 获取总绩点
  void getTotalPoint() {
    List allTerm =
        SpData<List<String>>(key: KeyAssets.termList, defaultValue: []).get();
    List<GradeBean> allGradeList = [];
    for (String term in allTerm) {
      GradeDBManager.getGradesOfTerm(term).then((dbValue) {
        List<GradeBean> gradeList = dbValue
            .map((e) => GradeBean.fromJson(jsonDecode(e.content)))
            .toList();
        allGradeList.addAll(gradeList);
        if (term == DateInfo.nowTerm) {
          model.totalPoint = GradeUtil.getSumPoint(allGradeList);
          SpUtil.put(KeyAssets.totalPoint, model.totalPoint);
          notifyListeners();
          return;
        }
      });
    }
  }
}
