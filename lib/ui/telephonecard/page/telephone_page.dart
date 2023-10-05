import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/telephonecard/data/telephone_picker_type.dart';
import 'package:csust_edu_system/ui/telephonecard/page/order_page.dart';
import 'package:csust_edu_system/ui/telephonecard/view/telephone_add_wechat_view.dart';
import 'package:csust_edu_system/ui/telephonecard/view/telephone_banner_view.dart';
import 'package:csust_edu_system/ui/telephonecard/view/telephone_button_view.dart';
import 'package:csust_edu_system/ui/telephonecard/view/telephone_edit_view.dart';
import 'package:csust_edu_system/ui/telephonecard/view/telephone_function_bar_view.dart';
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
              TelephoneBannerView(
                imgList: telephoneImgList,
              ),
              const TelephoneFunctionBarView(),
              _card(
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    _rowTelephonePicker(
                      StringAssets.schoolArea,
                      StringAssets.selectSchoolArea,
                      _telephoneViewModel.model.school,
                      telephoneSchoolList,
                      60,
                      TelephonePickerType.schoolArea,
                    ),
                    _divider(),
                    _rowTelephonePicker(
                      StringAssets.package,
                      StringAssets.selectPackage,
                      _telephoneViewModel.model.package,
                      telephonePackageList,
                      60,
                      TelephonePickerType.package,
                    ),
                    _divider(),
                    _rowTelephonePicker(
                      StringAssets.cardNumber,
                      StringAssets.selectCardNumber,
                      _telephoneViewModel.model.number,
                      [],
                      60,
                      TelephonePickerType.number,
                    ),
                    _divider(),
                    _rowTelephonePicker(
                        StringAssets.cardReceivingTime,
                        StringAssets.selectTime,
                        _telephoneViewModel.model.time,
                        timeList,
                        24,
                        TelephonePickerType.cardReceivingTime),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              _card(
                Column(
                  children: [
                    TelephoneEditView(
                        controller: _telephoneViewModel.model.nameController,
                        title: StringAssets.name,
                        size: 58,
                        hint: StringAssets.nameHint),
                    TelephoneEditView(
                        controller:
                            _telephoneViewModel.model.phoneNumberController,
                        title: StringAssets.contactPhoneNumber,
                        size: 24,
                        hint: StringAssets.contactPhoneNumberHint),
                    TelephoneEditView(
                        controller: _telephoneViewModel.model.addressController,
                        title: StringAssets.address,
                        size: 24,
                        hint: StringAssets.addressHint),
                  ],
                ),
              ),
              _card(const TelephoneAddWeChatView()),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Text(
                  StringAssets.tipsTelephone,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Text(
                  StringAssets.disclaimers,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 15, 50, 80),
                child: TelephoneButtonView(
                  onPress: () {
                    _createOder();
                  },
                ),
              ),
            ],
          ),
        ));
  }

  ///获取分割线
  Widget _divider() {
    return const Divider(
        thickness: 1, indent: 30, endIndent: 30, color: Colors.black12);
  }

  /// 获取telephonePicker
  ///
  /// [text] text的值
  /// [tittle] 选择器的标题title
  /// [value] 选择器的值
  /// [pickerData] 选择器的列表数据
  /// [size] padding的左边距
  /// [type] 选择器类型
  Widget _rowTelephonePicker(String text, String title, String value,
      List pickerData, double size, TelephonePickerType type) {
    return Row(
      children: [
        const SizedBox(
          width: 30,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        Expanded(
          child: TelephonePickerView(
            title: title,
            text: value,
            pickerData: pickerData,
            size: size,
            type: type,
          ),
        )
      ],
    );
  }

  /// 获取Card
  ///
  /// [child] Card内的Widget
  Widget _card(Widget child) {
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: child,
    );
  }

  /// 提交订单
  void _createOder() {
    int id = _telephoneViewModel.model.cardId;
    String name = _telephoneViewModel.model.nameController.text;
    String mobile = _telephoneViewModel.model.phoneNumberController.text;
    String dormitory = _telephoneViewModel.model.addressController.text;
    String freeDate = _telephoneViewModel.model.time;
    String school = _telephoneViewModel.model.school;
    _telephoneViewModel.createOder(
        id, name, mobile, dormitory, freeDate, school);
    context.pushReplacement(const OrderPage());
  }
}
