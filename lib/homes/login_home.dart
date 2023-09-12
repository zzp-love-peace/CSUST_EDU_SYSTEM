import 'dart:convert';

import 'package:csust_edu_system/data/date_info.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/network/http_manager.dart';
import 'package:csust_edu_system/provider/theme_color_provider.dart';
import 'package:csust_edu_system/utils/date_util.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:csust_edu_system/widgets/hint_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_tab_home.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({Key? key}) : super(key: key);

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isRemember = false;
  late final SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            const SizedBox(
              height: 100,
            ),
            _loginText(),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: UsernameTextField(_usernameController)),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: PasswordTextField(_passwordController)),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _rememberCheckBox())),
            Padding(
                padding: const EdgeInsets.fromLTRB(50, 15, 50, 0),
                child: _loginButton()),
            Padding(
                padding: const EdgeInsets.fromLTRB(100, 15, 100,0),
                child: TextButton(
                  child: Text(
                    '登录异常？登录须知',
                    style: TextStyle(
                        fontSize: 14, color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                       _alertDialog();
                  },
                ),
            )

          ],
        ),
      ),
    );
  }
  _alertDialog() async {
    var result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("信息提示",style: TextStyle(
                fontSize: 16, color: Colors.black),),
            content: const Text("新生数据已经全部导入教务系统，网址: http"
                "://xk.csust.edu.cn ，也可通过教务处官网通过链接进入教务系统，其初始密码为其8位出生日期。"
                "一定要在官网修改完密码后再登录app哦。忘记密码的联系本班学委或辅导员，"
                "密码要求是大小写字母+数字+特殊字符",style: TextStyle(fontSize: 15)),
           shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))
          ),

            actions: [
              TextButton(
                  child: Text("确定"),
                  onPressed: () {
                    print("确定");
                    Navigator.pop(context, "Ok");
                  })
            ],
          );
        });

    print(result);
  }


  Text _loginText() {
    return const Text(
      "登录",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  ElevatedButton _loginButton() {
    return ElevatedButton(
      child: const SizedBox(
        child: Center(
          child: Text(
            "登录",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        width: double.infinity,
      ),
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 10, 0, 10)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      ),
      onPressed: () {
        _doLogin(_usernameController.text, _passwordController.text);
      },
    );
  }

  List<Widget> _rememberCheckBox() {
    return [
      Checkbox(
          value: _isRemember,
          onChanged: (value) {
            setState(() {
              if (value != null) {
                _isRemember = value;
              }
            });
          }),
      const Text(
        "记住密码&自动登录",
        style: TextStyle(fontSize: 14, color: Colors.black),
      )
    ];
  }

  _doLogin(String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      SmartDialog.compatible.showLoading(
        msg: "登录中",
        backDismiss: false,
      );
      var value = await HttpManager().login(username, password);
      if (value.isNotEmpty) {

        if (value['code'] == 200) {
          print(value);
          _saveData();
          StuInfo.token = value['data']['token'];
          StuInfo.cookie = value['data']['cookie'];
          var dateData =
              await HttpManager().getDateData(StuInfo.cookie, StuInfo.token);
          if (dateData.isNotEmpty) {
            print('dateData$dateData');
            if (dateData['code'] == 200) {
              print(dateData);
              DateInfo.initData(dateData['data']);
              var stuData =
                  await HttpManager().getStuInfo(StuInfo.cookie, StuInfo.token);
              if (stuData.isNotEmpty) {
                if (stuData['code'] == 200) {
                  StuInfo.initData(stuData['data']);
                  _saveLoginData();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const BottomTabHome()));
                } else {
                  SmartDialog.compatible
                      .showToast('', widget: const CustomToast('登录异常'));
                }
              } else {
                SmartDialog.compatible
                    .showToast('', widget: const CustomToast('登录异常'));
              }
            } else {
              DateInfo.totalWeek=20;
              var stuData =
              await HttpManager().getStuInfo(StuInfo.cookie, StuInfo.token);
              if (stuData.isNotEmpty) {
                if (stuData['code'] == 200) {
                  StuInfo.initData(stuData['data']);
                  _saveLoginData();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const BottomTabHome()));
                } else {
                  SmartDialog.compatible
                      .showToast('', widget: const CustomToast('登录异常'));
                }
              } else {
                SmartDialog.compatible
                    .showToast('', widget: const CustomToast('登录异常'));
              }

            }
            String a=DateInfo.nowDate;
            print('DateInfo.nowDate$a');
          } else {
            DateInfo.totalWeek=20;
            SmartDialog.compatible
                .showToast('', widget: const CustomToast('登录异常'));

          }
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const BottomTabHome()));
          // var allCourseData = await HttpManager().getAllCourse(StuInfo.token,
          //     StuInfo.cookie, DateInfo.nowTerm, DateInfo.totalWeek);
          // _saveLoginData(allCourseData);
        } else {
          SmartDialog.compatible
              .show(widget: HintDialog(title: '提示', subTitle: value['msg']));
        }
      } else {
        SmartDialog.compatible
            .showToast('', widget: const CustomToast('出现异常了'));
      }
      SmartDialog.dismiss();
    } else {
      SmartDialog.compatible
          .showToast('', widget: const CustomToast('账号或密码不能为空'));
    }
  }

  _initData() async {
    prefs = await SharedPreferences.getInstance();
    String colorKey = prefs.getString('color') ?? 'blue';
    // 设置初始化主题颜色
    Provider.of<ThemeColorProvider>(context, listen: false).setTheme(colorKey);
    final String? username = prefs.getString("username");
    final String? password = prefs.getString("password");
    setState(() {
      _isRemember = prefs.getBool("isRemember") ?? false;
      if (username != null) {
        _usernameController.text = username;
      }
      if (password != null) {
        _passwordController.text = password;
      }
    });
  }

  _saveData() async {
    if (_isRemember) {
      await prefs.setString("password", _passwordController.text);
      await prefs.setBool("isRemember", _isRemember);
    }
    await prefs.setString("username", _usernameController.text);
  }

  _saveLoginData() async {
    prefs.setString('name', StuInfo.name);
    prefs.setString('stuId', StuInfo.stuId);
    prefs.setString('college', StuInfo.college);
    prefs.setString('major', StuInfo.major);
    prefs.setString('className', StuInfo.className);
    prefs.setString('avatar', StuInfo.avatar);
    prefs.setString('nowTerm', DateInfo.nowTerm);
    prefs.setString('nowDate', DateInfo.nowDate);
    prefs.setInt('nowWeek', DateInfo.nowWeek);
    prefs.setInt('totalWeek', DateInfo.totalWeek);
  }

  _initLoginData() {
    StuInfo.name = prefs.getString('name') ?? '';
    StuInfo.stuId = prefs.getString('stuId') ?? '';
    StuInfo.college = prefs.getString('college') ?? '';
    StuInfo.major = prefs.getString('major') ?? '';
    StuInfo.className = prefs.getString('className') ?? '';
    DateInfo.nowTerm = prefs.getString('nowTerm') ?? '';
    DateInfo.totalWeek = prefs.getInt('totalWeek') ?? 0;
    int lastWeek = prefs.getInt('nowWeek') ?? -1;
    String lastDate = prefs.getString('nowDate') ?? '';
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
    // String courseData = prefs.getString('courseData') ?? '';
    // return courseData;
  }
}

class UsernameTextField extends StatefulWidget {
  final TextEditingController _controller;
  const UsernameTextField(this._controller,{Key? key}) : super(key: key);

  @override
  State<UsernameTextField> createState() => _UsernameTextFieldState();
}

class _UsernameTextFieldState extends State<UsernameTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._controller,
      keyboardType: TextInputType.number,
      maxLines: 1,
      maxLength: 12,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        labelText: "学号",
        errorText: null,
        prefixIcon: Icon(Icons.account_box,)
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController _controller;

  const PasswordTextField(this._controller, {Key? key}) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  var _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._controller,
      obscureText: _passwordVisible,
      maxLines: 1,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          labelText: "密码",
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
              icon: _passwordVisible
                  ? const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    )
                  : const Icon(Icons.visibility_off),
              color: Colors.grey)),
    );
  }
}
