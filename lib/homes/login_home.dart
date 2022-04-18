import 'dart:convert';

import 'package:csust_edu_system/data/date_info.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/network/network.dart';
import 'package:csust_edu_system/utils/date_util.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:csust_edu_system/widgets/hint_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

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
                child: _loginButton())
          ],
        ),
      ),
    );
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
            style: TextStyle(fontSize: 18),
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
      SmartDialog.showLoading(
          msg: "登录中",
          backDismiss: false,
          background: Colors.black.withOpacity(0.7));
      var value = await HttpManager().login(username, password);
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          SmartDialog.showToast('', widget: const CustomToast('登录成功'));
          _saveData();
          StuInfo.initData(value['data']);
          DateInfo.initData(value['data']);
          try {
            var allCourseData = await HttpManager().getAllCourse(StuInfo.token,
                StuInfo.cookie, DateInfo.nowTerm, DateInfo.totalWeek);
            _saveLoginData(allCourseData);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => BottomTabHome(allCourseData)));
          } on Exception {
            String list = await _initLoginData();
            if (list.isNotEmpty) {
              List data = json.decode(list);
              SmartDialog.showToast('', widget: const CustomToast('出现异常了'));
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => BottomTabHome(data)));
            } else {
              SmartDialog.show(
                  widget: const HintDialog(
                      title: '提示', subTitle: '服务器异常且暂未保存课程表，请稍后再试'));
            }
          }
        } else {
          SmartDialog.show(
              widget: HintDialog(
                  title: '提示', subTitle: value['msg']));
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginHome()));
        }
      } else {
        SmartDialog.showToast('', widget: const CustomToast('出现异常了'));
      }
      SmartDialog.dismiss();
    } else {
      SmartDialog.showToast('', widget: const CustomToast('账号或密码不能为空'));
    }
  }

  _initData() async {
    prefs = await SharedPreferences.getInstance();
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

  _saveLoginData(List courseData) async {
    prefs.setString('name', StuInfo.name);
    prefs.setString('stuId', StuInfo.stuId);
    prefs.setString('college', StuInfo.college);
    prefs.setString('major', StuInfo.major);
    prefs.setString('className', StuInfo.className);
    prefs.setString('nowTerm', DateInfo.nowTerm);
    prefs.setString('nowDate', DateInfo.nowDate);
    prefs.setInt('nowWeek', DateInfo.nowWeek);
    prefs.setInt('totalWeek', DateInfo.totalWeek);
    prefs.setString('courseData', jsonEncode(courseData));
  }

  Future<String> _initLoginData() async {
    StuInfo.token = "";
    StuInfo.cookie = "";
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
    String courseData = prefs.getString('courseData') ?? '';
    return courseData;
  }
}

class UsernameTextField extends StatefulWidget {
  final TextEditingController _controller;

  const UsernameTextField(this._controller, {Key? key}) : super(key: key);

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
        labelText: "用户名",
        errorText: null,
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
