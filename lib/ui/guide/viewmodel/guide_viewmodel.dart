import 'package:csust_edu_system/arch/basedata/empty_model.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/dialog/hint_dialog.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/network/data/http_response_code.dart';
import 'package:csust_edu_system/ui/login/page/login_page.dart';
import 'package:csust_edu_system/ui/login/service/login_service.dart';
import 'package:csust_edu_system/util/sp/sp_util.dart';

import '../../../data/date_info.dart';
import '../../../data/stu_info.dart';
import '../../../util/date_util.dart';
import '../../bottomtab/page/bottom_tab_page.dart';
import '../../login/jsonbean/login_bean.dart';

/// 开屏引导默认展示时间
const int guideTimeMill = 1800;

/// 开屏引导ViewModel
///
/// @author zzp
/// @since 2023/9/18
/// @version v1.8.8
class GuideViewModel extends BaseViewModel<EmptyModel, LoginService> {
  GuideViewModel({required super.model});

  @override
  LoginService? createService() => LoginService();

  /// 准备工作
  /// 1、初始化主题色
  /// 2、初始化SpUtil
  /// 3、登录等操作
  void doPreWork() {
    context.initThemeColor();
    var username = SpUtil.get(KeyAssets.username, StringAssets.emptyStr);
    var password = SpUtil.get(KeyAssets.password, StringAssets.emptyStr);
    var isRemember = SpUtil.get(KeyAssets.isRemember, false);
    if (isRemember && [username, password].isAllNotBlank()) {
      _login(username, password);
    } else {
      Future.delayed(const Duration(milliseconds: guideTimeMill), () {
        context.pushReplacement(const LoginPage());
      });
    }
  }

  /// 登录
  ///
  /// [username] 用户名
  /// [password] 密码
  void _login(String username, String password) {
    service?.login(username, password,
      onDataSuccess: (data, msg) {
        var loginBean = LoginBean.fromJson(data);
        StuInfo.token = loginBean.token;
        StuInfo.cookie = loginBean.cookie;
        _getStuInfo(loginBean.cookie);
        _getDateInfo(loginBean.cookie);
      },
      onDataFail: (code, msg) {
        if (code == HttpResponseCode.stuIdOrPasswordWrong) {
          HintDialog(title: StringAssets.tips, subTitle: msg).showDialog();
        } else {
          msg.showToast();
        }
      },
      onFinish: (isSuccess) {
        if (!isSuccess) {
          _doOnLoginDataFail();
          context.pushReplacement( const BottomTabPage());
        }
      },
    );
  }

  /// 获取日期相关数据
  ///
  /// [cookie] cookie
  void _getDateInfo(String cookie) {
    service?.getDateData(cookie,
      onDataSuccess: (data, msg) {
        DateInfo.initData(data);
      },
      onFinish: (isSuccess) {
        if (!isSuccess) {
          DateInfo.initDataFromSp();
          _computeNowWeek();
        }
        context.pushReplacement( const BottomTabPage());
      }
    );
  }

  /// 获取学生信息相关数据
  ///
  /// [cookie] cookie
  void _getStuInfo(String cookie) {
    service?.getStuInfo(cookie,
      onDataSuccess: (data, msg) {
        StuInfo.initData(data);
      },
      onDataFail: (code, msg) {
        StuInfo.initDataFromSp();
      }
    );
  }

  /// 请求数据失败后从缓存读取数据，并计算当前周数
  void _doOnLoginDataFail() {
    DateInfo.initDataFromSp();
    StuInfo.initDataFromSp();
    _computeNowWeek();
  }

  /// 计算当前周数
  void _computeNowWeek() {
    int lastWeek = DateInfo.nowWeek;
    String lastDate = DateInfo.nowDate;
    DateInfo.nowDate = (DateTime.now().toString()).split(' ')[0];
    if (lastWeek > 0) {
      List lastList = DateUtil.splitDate(lastDate);
      final last = DateTime(lastList[0], lastList[1], lastList[2]);
      final diff = DateTime.now().difference(last).inDays;
      int weekOfLast = DateUtil.date2Week(lastDate);
      int weekOfToday = DateUtil.date2Week(DateInfo.nowDate);
      DateInfo.nowWeek = lastWeek + diff ~/ 7;
      if (weekOfToday < weekOfLast) DateInfo.nowWeek++;
    } else {
      DateInfo.nowWeek = -1;
    }
  }
}