import '../ass/key_assets.dart';
import '../ass/string_assets.dart';
import '../util/sp/sp_util.dart';

/// 学生信息相关类
class StuInfo {
  /// token
  static String token = StringAssets.emptyStr;

  /// cookie
  static String cookie = StringAssets.emptyStr;

  /// 学生id
  static int id = -1;

  /// 姓名
  static String name = StringAssets.emptyStr;

  /// 学号
  static String stuId = StringAssets.emptyStr;

  /// 学院
  static String college = StringAssets.emptyStr;

  /// 专业
  static String major = StringAssets.emptyStr;

  /// 班级
  static String className = StringAssets.emptyStr;

  /// 昵称
  static String username = StringAssets.emptyStr;

  /// 性别 false为女 true为男
  static bool sex = true;

  /// 头像
  static String avatar = StringAssets.emptyStr;

  /// 初始化数据
  ///
  /// [stuData] 学生信息相关json数据
  static initData(Map stuData) {
    id = stuData[KeyAssets.id];
    sex = stuData[KeyAssets.sex];
    username = stuData[KeyAssets.username];
    avatar = stuData[KeyAssets.avatar];
    name = stuData[KeyAssets.name] ?? StringAssets.emptyStr;
    stuId = stuData[KeyAssets.stuId];
    college = stuData[KeyAssets.college] ?? StringAssets.emptyStr;
    major = stuData[KeyAssets.major] ?? StringAssets.emptyStr;
    className = stuData[KeyAssets.className] ?? StringAssets.emptyStr;
  }

  /// 保存数据
  static void saveData() {
    SpUtil.put(KeyAssets.name, StuInfo.name);
    SpUtil.put(KeyAssets.stuId, StuInfo.stuId);
    SpUtil.put(KeyAssets.college, StuInfo.college);
    SpUtil.put(KeyAssets.major, StuInfo.major);
    SpUtil.put(KeyAssets.className, StuInfo.className);
    SpUtil.put(KeyAssets.avatar, StuInfo.avatar);
  }

  /// 从SharedPreferences中初始化数据
  static void initDataFromSp() {
    StuInfo.name = SpUtil.get<String>(KeyAssets.name, StringAssets.emptyStr);
    StuInfo.stuId = SpUtil.get<String>(KeyAssets.stuId, StringAssets.emptyStr);
    StuInfo.college =
        SpUtil.get<String>(KeyAssets.college, StringAssets.emptyStr);
    StuInfo.major = SpUtil.get<String>(KeyAssets.major, StringAssets.emptyStr);
    StuInfo.className =
        SpUtil.get<String>(KeyAssets.className, StringAssets.emptyStr);
    StuInfo.avatar =
        SpUtil.get<String>(KeyAssets.avatar, StringAssets.emptyStr);
  }
}
