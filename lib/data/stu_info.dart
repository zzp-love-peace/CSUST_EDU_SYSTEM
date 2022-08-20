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
    name = stuData['name'];
    stuId = stuData['stuId'];
    college = stuData['college'];
    major = stuData['major'];
    className = stuData['className'];
  }
}
