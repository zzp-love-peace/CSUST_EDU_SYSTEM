import '../ass/key_assets.dart';
import '../ass/string_assets.dart';
import '../util/sp/sp_util.dart';

class StuInfo {
  static String token = "";
  static String cookie = "";
  static int id = -1;
  // 姓名
  static String name = "";
  // 学号
  static String stuId = "";
  // 学院
  static String college = "";
  // 专业
  static String major = "";
  // 班级
  static String className = "";
  // 昵称
  static String username = "";
  // 性别 false为女 true为男
  static bool sex = true;
  // 头像
  static String avatar = "";

  static initData(Map stuData) {
    print(token);
    id = stuData['id'];
    sex = stuData['sex'];
    username = stuData['username'];
    avatar = stuData['avatar'];
    // print('avatar$avatar');
    name = stuData['name'] ?? '';
    stuId = stuData['stuId'];
    college = stuData['college'] ?? '';
    major = stuData['major'] ?? '';
    className = stuData['className'] ?? '';
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
    StuInfo.college = SpUtil.get<String>(KeyAssets.college, StringAssets.emptyStr);
    StuInfo.major = SpUtil.get<String>(KeyAssets.major, StringAssets.emptyStr);
    StuInfo.className = SpUtil.get<String>(KeyAssets.className, StringAssets.emptyStr);
    StuInfo.avatar = SpUtil.get<String>(KeyAssets.avatar, StringAssets.emptyStr);
  }
}
