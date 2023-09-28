import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/telephonecard/model/telephone_model.dart';

import '../../../ass/key_assets.dart';
import '../../../ass/string_assets.dart';
import '../../../util/sp/sp_data.dart';
import '../jsonbean/card_number_bean.dart';
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

  /// 校区选择器回调
  void schoolCallBack(String school) {
    model.school = school;
    notifyListeners();
  }

  /// 卡号选择器回调
  void numberCallBack(String number) {
    model.number = number;
    notifyListeners();
  }

  /// 套餐选择器回调
  void packageCallBack(String package) {
    model.package = package;
    notifyListeners();
  }

  /// 收卡时间选择器回调
  void timeCallBack(String time) {
    model.time = time;
    notifyListeners();
  }

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
    _initTimeList();
    // notifyListeners();
  }

  /// 初始化收卡时间列表
  void _initTimeList() {
    model.timeList = [
      model.now + StringAssets.morning,
      model.now + StringAssets.afternoon,
      model.now + StringAssets.night,
      model.tomorrow + StringAssets.morning,
      model.tomorrow + StringAssets.afternoon,
      model.tomorrow + StringAssets.night,
      model.bigTomorrow + StringAssets.morning,
      model.bigTomorrow + StringAssets.afternoon,
      model.bigTomorrow + StringAssets.night,
    ];
  }

  /// 保存电话卡页数据
  void saveTelephonePageData() {
    _spSchool.set(model.school);
    _spPackage.set(model.package);
    _spName.set(model.nameController.text);
    _spPhoneNumber.set(model.phoneNumberController.text);
    _spAddress.set(model.addressController.text);
  }

  /// 根据套餐，校区获取卡号列表
  List<String> getNumberList(String school, String package) {
    List<String> numberList = [];
    if (school.startsWith(StringAssets.clickSelect) ||
        package.startsWith(StringAssets.clickSelect)) {
      '校区或套餐未选择'.showToast();
    } else {
      if (package == StringAssets.package59) {
        package = '59';
      }
      if (package == StringAssets.package28) {
        package = '28';
      }
      service?.getCardByKind(school, package, onDataSuccess: (data, msg) {
        List records = data[KeyAssets.records];
        if (records.isNotEmpty) {
          for (var record in records) {
            var cardNumberBean = CarDNumberBean.fromJson(record);
            numberList.add(cardNumberBean.mobile);
          }
        }
      });
    }
    notifyListeners();
    return numberList;
  }
}
