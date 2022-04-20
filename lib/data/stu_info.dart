class StuInfo {
  static String token = "";
  static String cookie = "";

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

  static initData(Map loginData) {
    token = loginData['token'];
    cookie = loginData['cookie'];
    print(token);
    name = loginData['stuInfo']['name'];
    stuId = loginData['stuInfo']['stuId'];
    college = loginData['stuInfo']['college'];
    major = loginData['stuInfo']['major'];
    className = loginData['stuInfo']['className'];
  }
}
