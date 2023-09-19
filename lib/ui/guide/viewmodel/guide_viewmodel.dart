import 'package:csust_edu_system/arch/basedata/empty_model.dart';
import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/network/data/http_response_code.dart';
import 'package:csust_edu_system/ui/login/service/login_service.dart';
import 'package:csust_edu_system/ui/login/view/login_page.dart';
import 'package:csust_edu_system/utils/extension_uitl.dart';
import 'package:csust_edu_system/utils/sp/sp_util.dart';
import 'package:provider/provider.dart';
import '../../../data/date_info.dart';
import '../../../data/stu_info.dart';
import '../../../homes/bottom_tab_home.dart';
import '../../../jsonbean/login_bean.dart';
import '../../../provider/course_term_provider.dart';
import '../../../utils/date_util.dart';
import '../../../utils/log.dart';

/// 开屏引导默认展示时间
const int guideTimeMill = 1800;

/// 开屏引导ViewModel
///
/// @author zzp
/// @since 2023/9/18
class GuideViewModel extends BaseViewModel<EmptyModel> {
  GuideViewModel({required super.model});

  final LoginService _service = LoginService();

  /// 准备工作
  /// 1、初始化主题色
  /// 2、初始化SpUtil
  /// 3、登录等操作
  void doPreWork() {
    context.initThemeColor();
    var username = SpUtil.get(KeyAssets.username, '');
    var password = SpUtil.get(KeyAssets.password, '');
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
    _service.login(username, password,
      onDataSuccess: (data, msg) {
        var loginBean = LoginBean.fromJson(data);
        StuInfo.token = loginBean.token;
        StuInfo.cookie = loginBean.cookie;
        _getStuInfo(loginBean.cookie);
        _getDateInfo(loginBean.cookie);
      },
      onDataFail: (code, msg) {
        if (code == HttpResponseCode.systemError
            || code == HttpResponseCode.schoolSystemError) {
          _doOnLoginDataFail();
        }
        msg.showToast();
        Log.e('code=>$code, msg=>$msg');
      },
      onFinish: (isSuccess) {
        if (!isSuccess) {
          context.pushReplacement( const BottomTabHome());
        }
      },
    );
  }

  /// 获取日期相关数据
  ///
  /// [cookie] cookie
  void _getDateInfo(String cookie) {
    _service.getDateData(cookie,
      onDataSuccess: (data, msg) {
        DateInfo.initData(data);
      },
      onDataFail: (code, msg) {
        DateInfo.initDataFromSp();
        computeNowWeek();
      },
      onFinish: (_) {
        Provider.of<CourseTermProvider>(context, listen: false)
            .setNowTerm(DateInfo.nowTerm);
        context.pushReplacement( const BottomTabHome());
      }
    );
  }

  /// 获取学生信息相关数据
  ///
  /// [cookie] cookie
  void _getStuInfo(String cookie) {
    _service.getStuInfo(cookie,
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
    computeNowWeek();
  }

  /// 计算当前周数
  void computeNowWeek() {
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