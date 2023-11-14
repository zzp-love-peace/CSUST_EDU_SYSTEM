import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/dialog/hint_dialog.dart';
import 'package:csust_edu_system/common/versionchecker/jsonbean/version_checker_bean.dart';
import 'package:csust_edu_system/common/versionchecker/model/version_checker_model.dart';
import 'package:csust_edu_system/common/versionchecker/service/version_checker_service.dart';
import 'package:csust_edu_system/common/versionchecker/view/version_upudate_dialog_view.dart';
import 'package:csust_edu_system/common/versionchecker/viewmodel/version_update_dialog_view_model.dart';
import 'package:csust_edu_system/data/app_info.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:flutter_app_update/azhon_app_update.dart';
import 'package:flutter_app_update/update_model.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import '../../dialog/select_dialog.dart';

/// 版本检查ViewModel
///
/// @author zzp
/// @since 2023/10/24
/// @version v1.8.8
class VersionCheckerViewModel
    extends BaseViewModel<VersionCheckerModel, VersionCheckerService> {
  VersionCheckerViewModel({required super.model});

  @override
  VersionCheckerService? createService() => VersionCheckerService();

  /// 检查版本
  ///
  /// [isBegin] 是否是启动app的首次检查更新
  void checkoutVersion({bool isBegin = false}) {
    service?.getLastVersion(
      onDataSuccess: (data, msg) {
        var versionInfoBean = VersionInfoBean.fromJson(data);
        if (versionInfoBean.version.compareTo(AppInfo.version) > 0) {
          setHasNewVersion(true);
          if (isBegin && versionInfoBean.forcedUpdating) {
            HintDialog(
                title: StringAssets.haveNewVersion,
                subTitle: versionInfoBean.info,
                positiveText: StringAssets.updateNow,
                okCallback: () {
                  _showUpdateDialog(versionInfoBean.apkPath);
                }).showDialog(backDismiss: false);
          } else {
            SelectDialog(
                title: StringAssets.haveNewVersion,
                subTitle: versionInfoBean.info,
                positiveText: StringAssets.updateNow,
                negativeText: StringAssets.updateLater,
                okCallback: () {
                  _showUpdateDialog(versionInfoBean.apkPath);
                }).showDialog();
          }
        } else if (!isBegin) {
          StringAssets.newVersionTips.showToast();
        }
      },
    );
  }

  /// 展示下载Dialog
  void _showUpdateDialog(String apkPath) {
    UpdateModel model = UpdateModel(
      apkPath,
      StringAssets.csusterApk,
      StringAssets.appIconPath, // android res/mipmap 目录下的图片名称
      StringAssets.ipaPath,
    );
    AzhonAppUpdate.listener((map) {
      String type = map[KeyAssets.type];
      switch (type) {
        case StringAssets.startEnglish:
          const VersionUpdateDialogView().showDialog(backDismiss: false);
          break;
        case StringAssets.downloadingEnglish:
          int max = map[KeyAssets.max];
          int progress = map[KeyAssets.progress];
          var versionCheckerViewModel = context.read<VersionCheckerViewModel>();
          var versionUpdateDialogViewModel = versionCheckerViewModel
                  .readSonViewModel(KeyAssets.versionUpdateDialogViewModel)
              as VersionUpdateDialogViewModel;
          var curProgress = ((progress / max) * 100).floor();
          versionUpdateDialogViewModel.setCurProgress(curProgress);
          setHasNewVersion(false);
          break;
        case StringAssets.doneEnglish:
        case StringAssets.cancelEnglish:
          SmartDialog.dismiss();
          break;
        case StringAssets.errorEnglish:
          SmartDialog.dismiss();
          map[KeyAssets.exception].toString().showToast();
          break;
      }
    });
    AzhonAppUpdate.update(model).then((value) {
      if (!value) {
        const HintDialog(
                title: StringAssets.tips, subTitle: StringAssets.apkPathError)
            .showDialog();
      }
    });
  }

  /// 设置是否有新版本更新
  void setHasNewVersion(bool hasNewVersion) {
    model.hasNewVersion = hasNewVersion;
    notifyListeners();
  }
}
