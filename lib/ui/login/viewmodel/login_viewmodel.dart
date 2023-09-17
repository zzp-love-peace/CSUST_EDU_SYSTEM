import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/jsonbean/login_bean.dart';
import 'package:csust_edu_system/ui/login/model/login_model.dart';
import 'package:csust_edu_system/ui/login/service/login_service.dart';
import 'package:csust_edu_system/utils/extension_uitl.dart';
import 'package:csust_edu_system/utils/sp/sp_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import '../../../data/date_info.dart';
import '../../../data/stu_info.dart';
import '../../../homes/bottom_tab_home.dart';
import '../../../provider/theme_color_provider.dart';
import '../../../utils/log.dart';
import '../../../widgets/hint_dialog.dart';

/// 登录ViewModel
///
/// @author zzp
/// @since 2023/9/12
class LoginViewModel extends BaseViewModel<LoginModel> {
  LoginViewModel({required super.model});

  /// 登录Service
  final LoginService service = LoginService();
  /// sp-用户名
  final SpData<String> _spUsername =
      SpData(key: KeyAssets.username, defaultValue: StringAssets.emptyStr);
  /// sp-密码
  final SpData<String> _spPassword =
      SpData(key: KeyAssets.password, defaultValue: StringAssets.emptyStr);
  /// sp-是否记住密码
  final SpData<bool> _spIsRemember =
      SpData(key: KeyAssets.isRemember, defaultValue: false);
  /// sp-颜色
  final SpData<String> _spColor =
      SpData(key: KeyAssets.color, defaultValue: StringAssets.blue);

  /// 设置是否记住密码
  ///
  /// [isRemember] 是否记住密码
  void setIsRemember(bool isRemember) {
    model.isRemember = isRemember;
    notifyListeners();
  }

  /// 初始化登录页数据
  ///
  /// [context] context
  void initLoginPageData(BuildContext context) {
    var themeColorProvider = Provider.of<ThemeColorProvider>(context, listen: false);
    if (themeColorProvider.themeColor != _spColor.get()) {
      // 设置初始化主题颜色
      themeColorProvider.setTheme(_spColor.get());
    }
    model.isRemember = _spIsRemember.get();
    if (_spUsername.get().isNotEmpty) {
      model.usernameController.text = _spUsername.get();
    }
    if (_spPassword.get().isNotEmpty) {
      model.passwordController.text = _spPassword.get();
    }
    notifyListeners();
  }

  /// 登录
  ///
  /// [context] context
  /// [username] 用户名
  /// [password] 密码
  void doLogin(BuildContext context, String username, String password) {
    if ([username, password].isAllNotBlank()) {
      service.login(username, password, onPrepare: () {
        SmartDialog.showLoading(
            msg: StringAssets.loginLoading, backDismiss: false);
      }, onDataSuccess: (data, msg) {
        var loginBean = LoginBean.fromJson(data);
        _saveLoginPageData();
        StuInfo.token = loginBean.token;
        StuInfo.cookie = loginBean.cookie;
        _getDateInfo(loginBean.cookie);
        _getStuInfo(loginBean.cookie);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const BottomTabHome()));
      }, onDataFail: (code, msg) {
        SmartDialog.show(
            builder: (_) =>
                HintDialog(title: StringAssets.tips, subTitle: msg));
        Log.e('code=>$code, msg=>$msg');
      }, onFinish: () {
        SmartDialog.dismiss();
      });
    } else {
      StringAssets.usernameAndPasswordIsEmpty.showToast();
    }
  }

  /// 获取日期相关数据
  ///
  /// [cookie] cookie
  void _getDateInfo(String cookie) {
    service.getDateData(
      cookie,
      onDataSuccess: (data, msg) {
        DateInfo.initData(data);
        DateInfo.saveData();
      },
      onDataFail: (code, msg) {
        DateInfo.initDataFromSp();
      }
    );
  }

  /// 获取学生信息相关数据
  ///
  /// [cookie] cookie
  void _getStuInfo(String cookie) {
    service.getStuInfo(
        cookie,
        onDataSuccess: (data, msg) {
          StuInfo.initData(data);
          StuInfo.saveData();
        },
        onDataFail: (code, msg) {
          StuInfo.initDataFromSp();
        }
    );
  }

  /// 保存登录页数据
  void _saveLoginPageData() {
    if (model.isRemember) {
      _spPassword.set(model.passwordController.text);
      _spIsRemember.set(model.isRemember);
    }
    _spUsername.set(model.usernameController.text);
  }
}
