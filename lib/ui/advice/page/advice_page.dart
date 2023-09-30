import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/advice/model/advice_model.dart';
import 'package:csust_edu_system/ui/advice/view/advice_edittext_view.dart';
import 'package:csust_edu_system/ui/advice/view/phonenumber_edittext_view.dart';
import 'package:csust_edu_system/ui/advice/view/submit_button_view.dart';
import 'package:csust_edu_system/util/log.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ass/string_assets.dart';
import '../viewmodel/advice_viewmodel.dart';

/// 意见反馈页
///
/// @author bmc
/// @since 2023/9/30
/// @version v1.8.8
class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => AdviceViewModel(model: AdviceModel())),
    ], child: const AdviceHome());
  }
}

/// 反馈Home
///
/// @author bmc
/// @since 2023/9/30
class AdviceHome extends StatefulWidget {
  const AdviceHome({super.key});

  @override
  State<AdviceHome> createState() => _AdviceHomeState();
}

class _AdviceHomeState extends State<AdviceHome> {
  /// 登录页ViewModel
  late AdviceViewModel _adviceViewModel;

  @override
  void initState() {
    super.initState();
    _adviceViewModel = context.readViewModel<AdviceViewModel>();
  }

  @override
  void dispose() {
    super.dispose();
    _adviceViewModel.model.adviceController.dispose();
    _adviceViewModel.model.phonenumController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          StringAssets.advice,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: PhoneNumEdittextView(
                  controller: _adviceViewModel.model.phonenumController,
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: AdviceEdittextView(
                    controller: _adviceViewModel.model.adviceController)),
            Padding(
                padding: const EdgeInsets.fromLTRB(50, 15, 50, 0),
                child: SubmitButtonView(onPress: () {
                  var phone = _adviceViewModel.model.phonenumController.text;
                  var advice = _adviceViewModel.model.adviceController.text;
                  Log.d('phone=>$phone, advice=>$advice');
                  _adviceViewModel.addAdvice(advice, phone);
                }))
          ],
        ),
      ),
    );
  }
}
