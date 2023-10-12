import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/telephonecard/model/telephone_model.dart';

import '../../../ass/key_assets.dart';
import '../../../ass/string_assets.dart';
import '../../../util/sp/sp_data.dart';
import '../page/order_page.dart';
import '../service/telephone_service.dart';

/// 电话卡ViewModel
///
/// @author wk
/// @since 2023/9/25
/// @version v1.8.8
class TelephoneViewModel
    extends BaseViewModel<TelephoneModel, TelephoneService> {
  TelephoneViewModel({required super.model});

  @override
  TelephoneService? createService() => TelephoneService();

  /// sp-校区
  final SpData<String> _spSchool =
      SpData(key: KeyAssets.school, defaultValue: StringAssets.emptyStr);

  /// sp-套餐
  final SpData<String> _spPackage =
      SpData(key: KeyAssets.package, defaultValue: StringAssets.emptyStr);

  /// sp-姓名
  final SpData<String> _spName =
      SpData(key: KeyAssets.phoneName, defaultValue: StringAssets.emptyStr);

  /// sp-联系电话
  final SpData<String> _spPhoneNumber =
      SpData(key: KeyAssets.phoneNumber, defaultValue: StringAssets.emptyStr);

  /// sp-详细地址
  final SpData<String> _spAddress =
      SpData(key: KeyAssets.address, defaultValue: StringAssets.emptyStr);

  /// 初始化电话卡页数据
  void initTelephonePageData() {
    if (_spSchool.get().isNotEmpty) {
      model.school = _spSchool.get();
    }
    if (_spPackage.get().isNotEmpty) {
      model.package = _spPackage.get();
    }
    if (_spName.get().isNotEmpty) {
      model.nameController.text = _spName.get();
    }
    if (_spPhoneNumber.get().isNotEmpty) {
      model.phoneNumberController.text = _spPhoneNumber.get();
    }
    if (_spAddress.get().isNotEmpty) {
      model.addressController.text = _spAddress.get();
    }
  }

  /// 保存电话卡页数据
  void saveTelephonePageData() {
    _spSchool.set(model.school);
    _spPackage.set(model.package);
    _spName.set(model.nameController.text);
    _spPhoneNumber.set(model.phoneNumberController.text);
    _spAddress.set(model.addressController.text);
  }

  /// 提交电话卡订单
  ///
  /// [cardId] 卡号id
  /// [name] 姓名
  /// [mobile] 联系电话
  /// [dormitory] 详细地址
  /// [freeDate] 收卡时间
  /// [school] 校区
  void createOder(int cardId, String name, String mobile, String dormitory,
      String freeDate, String school) {
    if (cardId != -1 &&
        name.isNotEmpty &&
        mobile.isNotEmpty &&
        dormitory.isNotEmpty &&
        (!freeDate.startsWith(StringAssets.clickSelect) ||
            school == StringAssets.mail)) {
      service?.createOder(
        cardId,
        name,
        mobile,
        dormitory,
        freeDate,
        onDataSuccess: (data, msg) {
          StringAssets.createOrderSuccess.showToast();
          saveTelephonePageData();
          context.pushReplacement(const OrderPage());
        },
      );
    } else {
      StringAssets.addFullMsg.showToast();
    }
  }

  /// 销毁controller
  void disposeController() {
    model.nameController.dispose();
    model.phoneNumberController.dispose();
    model.addressController.dispose();
  }
}
