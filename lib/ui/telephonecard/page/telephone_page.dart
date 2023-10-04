import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/telephonecard/data/telephone_picker_type.dart';
import 'package:csust_edu_system/ui/telephonecard/view/banner_view.dart';
import 'package:csust_edu_system/ui/telephonecard/view/function_bar_view.dart';
import 'package:csust_edu_system/ui/telephonecard/view/telephone_add_wechat_view.dart';
import 'package:csust_edu_system/ui/telephonecard/view/telephone_button_view.dart';
import 'package:csust_edu_system/ui/telephonecard/view/telephone_edit_view.dart';
import 'package:csust_edu_system/ui/telephonecard/view/telephone_picker_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/telephone_data.dart';
import '../model/telephone_model.dart';
import '../viewmodel/telephone_viewmodel.dart';

/// 电话卡办理页
///
/// @author wk
/// @since 2023/9/25
/// @version v1.8.8
class TelephonePage extends StatelessWidget {
  const TelephonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => TelephoneViewModel(model: TelephoneModel())),
    ], child: const TelephoneHome());
  }
}

/// 电话卡办理页Home
///
/// @author wk
/// @since 2023/9/25
/// @version v1.8.8
class TelephoneHome extends StatefulWidget {
  const TelephoneHome({super.key});

  @override
  State<StatefulWidget> createState() => TelephoneHomeState();
}

class TelephoneHomeState extends State<TelephoneHome> {
  late TelephoneViewModel _telephoneViewModel;

  @override
  void initState() {
    super.initState();
    _telephoneViewModel = context.readViewModel<TelephoneViewModel>();
    _telephoneViewModel.initTelephonePageData();
  }

  @override
  void dispose() {
    _telephoneViewModel.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar.create(StringAssets.onlineHall),
        body: Center(
          child: ListView(
            children: [
              BannerView(
                imgList: telephoneImgList,
              ),
              const FunctionBarView(),
              Card(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        const Text(
                          StringAssets.schoolArea,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Expanded(
                          child: TelephonePickerView(
                            title: StringAssets.selectArea,
                            text: _telephoneViewModel.model.school,
                            pickerData: telephoneSchoolList,
                            callBack: (value) {
                              _telephoneViewModel.model.school = value;
                            },
                            size: 60,
                          ),
                        )
                      ],
                    ),
                    const Divider(
                        thickness: 1,
                        indent: 30,
                        endIndent: 30,
                        color: Colors.black12),
                    Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        const Text(
                          StringAssets.package0,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Expanded(
                          child: TelephonePickerView(
                            title: StringAssets.selectPackage,
                            text: _telephoneViewModel.model.package,
                            pickerData: telephonePackageList,
                            callBack: (value) {
                              _telephoneViewModel.model.package = value;
                            },
                            size: 60,
                          ),
                        )
                      ],
                    ),
                    const Divider(
                        thickness: 1,
                        indent: 30,
                        endIndent: 30,
                        color: Colors.black12),
                    Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        const Text(
                          StringAssets.telephoneNumber,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Expanded(
                          child: TelephonePickerView(
                            title: StringAssets.selectNumber,
                            text: _telephoneViewModel.model.number,
                            pickerData: const [],
                            size: 60,
                            type: TelephonePickerType.number,
                          ),
                        )
                      ],
                    ),
                    const Divider(
                        thickness: 1,
                        indent: 30,
                        endIndent: 30,
                        color: Colors.black12),
                    Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        const Text(
                          StringAssets.time0,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Expanded(
                          child: TelephonePickerView(
                            title: StringAssets.selectTime,
                            text: _telephoneViewModel.model.time,
                            pickerData: timeList,
                            callBack: (value) {
                              _telephoneViewModel.model.time = value;
                            },
                            size: 24,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Card(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  children: [
                    TelephoneEditView(
                        controller: _telephoneViewModel.model.nameController,
                        title: StringAssets.name,
                        size: 58,
                        hint: StringAssets.nameHint),
                    const SizedBox(
                      height: 10,
                    ),
                    TelephoneEditView(
                        controller:
                            _telephoneViewModel.model.phoneNumberController,
                        title: StringAssets.phoneNumber,
                        size: 24,
                        hint: StringAssets.phoneNumberHint),
                    const SizedBox(
                      height: 10,
                    ),
                    TelephoneEditView(
                        controller: _telephoneViewModel.model.addressController,
                        title: StringAssets.address,
                        size: 24,
                        hint: StringAssets.addressHint),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const Card(
                margin: EdgeInsets.fromLTRB(12, 0, 12, 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: TelephoneAddWeChatView(),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Text(
                  StringAssets.promptTelePhone,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Text(
                  StringAssets.service2,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 15, 50, 80),
                child: TelephoneButtonView(
                  onPress: () {
                    int id = _telephoneViewModel.model.cardId;
                    String name = _telephoneViewModel.model.nameController.text;
                    String mobile =
                        _telephoneViewModel.model.phoneNumberController.text;
                    String dormitory =
                        _telephoneViewModel.model.addressController.text;
                    String freeDate = _telephoneViewModel.model.time;
                    String school = _telephoneViewModel.model.school;
                    _telephoneViewModel.createOder(
                        id, name, mobile, dormitory, freeDate, school);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
