import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/login/model/login_model.dart';
import 'package:csust_edu_system/ui/login/model/password_edittext_model.dart';
import 'package:csust_edu_system/ui/login/view/login_button_view.dart';
import 'package:csust_edu_system/ui/login/view/password_edittext_view.dart';
import 'package:csust_edu_system/ui/login/view/remember_checkbox_view.dart';
import 'package:csust_edu_system/ui/login/view/username_edittext_view.dart';
import 'package:csust_edu_system/ui/login/viewmodel/login_viewmodel.dart';
import 'package:csust_edu_system/ui/login/viewmodel/password_edittext_viewmodel.dart';
import 'package:csust_edu_system/utils/extension_uitl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 登录页
///
/// @author zzp
/// @since 2023/9/12
/// @version v1.8.8
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => LoginViewModel(model: LoginModel())),
      ChangeNotifierProvider(
          create: (_) =>
              PasswordEditTextViewModel(model: PasswordEditTextModel())),
    ], child: const LoginHome());
  }
}

/// 登录Home
///
/// @author zzp
/// @since 2023/9/16
class LoginHome extends StatefulWidget {
  const LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  /// 登录页ViewModel
  late LoginViewModel _loginViewModel;

  @override
  void initState() {
    super.initState();
    _loginViewModel = context.readViewModel<LoginViewModel>();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _loginViewModel.initLoginPageData());
  }

  @override
  void dispose() {
    super.dispose();
    _loginViewModel.model.usernameController.dispose();
    _loginViewModel.model.passwordController.dispose();
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
            const Text(
              StringAssets.login,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: UsernameEditTextView(
                  controller: _loginViewModel.model.usernameController,
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: PasswordEditTextView(
                    controller: _loginViewModel.model.passwordController)),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
              child: RememberCheckBox(),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(50, 15, 50, 0),
                child: LoginButtonView(onPress: () {
                  var username = _loginViewModel.model.usernameController.text;
                  var password = _loginViewModel.model.passwordController.text;
                  _loginViewModel.doLogin(context, username, password);
                }))
          ],
        ),
      ),
    );
  }
}
