import 'package:csust_edu_system/arch/basedata/empty_model.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/mine/service/mine_service.dart';
import 'package:flutter/services.dart';

import '../../../ass/string_assets.dart';
import '../../../common/dialog/hint_dialog.dart';

/// 我的页面ViewModel
///
/// @author zzp
/// @since 2024/2/21
/// @version v1.8.8
class MineViewModel extends BaseViewModel<EmptyModel, MineService> {
  MineViewModel({required super.model});

  @override
  MineService? createService() => MineService();

  /// 获取交流群号
  void getCommunicationGroupID() {
    service?.getCommunicationGroupID(onDataSuccess: (data, msg) {
      Clipboard.setData(ClipboardData(text: data));
      StringAssets.copyQQGroupNumSuccess.showToast();
      HintDialog(title: StringAssets.tips, subTitle: '长理校园app交流群：$data')
          .showDialog();
    });
  }
}
