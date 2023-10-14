import 'dart:convert';

import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/electricity/service/electricity_service.dart';
import 'package:csust_edu_system/util/sp/sp_data.dart';

import '../data/electricity_data.dart';
import '../model/electricity_model.dart';

/// 查电费ViewModel
///
/// @author zzp
/// @since 2023/10/13
/// @version v1.8.8
class ElectricityViewModel
    extends BaseViewModel<ElectricityModel, ElectricityService> {
  ElectricityViewModel({required super.model});

  @override
  ElectricityService? createService() => ElectricityService();

  /// sp-校区
  final SpData<String> spSchoolArea =
      SpData(key: KeyAssets.area, defaultValue: StringAssets.clickSelectSchool);

  /// sp-宿舍
  final SpData<String> spSchoolBuilding = SpData(
      key: KeyAssets.building,
      defaultValue: StringAssets.clickSelectSchoolBuilding);

  /// sp-房间号
  final SpData<String> spRoom =
      SpData(key: KeyAssets.room, defaultValue: StringAssets.emptyStr);

  /// 初始化数据
  void initData() {
    model.schoolArea = spSchoolArea.get();
    model.schoolBuilding = spSchoolBuilding.get();
    model.roomController.text = spRoom.get();
  }

  /// 设置校区
  ///
  /// [schoolArea] 校区
  void setSchoolArea(String schoolArea) {
    model.schoolArea = schoolArea;
    notifyListeners();
  }

  /// 设置宿舍楼
  ///
  /// [schoolBuilding] 宿舍楼
  void setSchoolBuilding(String schoolBuilding) {
    model.schoolBuilding = schoolBuilding;
    notifyListeners();
  }

  /// 查询电费
  void doQueryElectricity() {
    var roomId = model.roomController.text;
    if (model.schoolArea.isEmpty) {
      StringAssets.pleaseSelectSchoolArea.showToast();
    } else if (model.schoolBuilding.isEmpty) {
      StringAssets.pleaseSelectSchoolBuilding.showToast();
    } else if (roomId.isEmpty) {
      StringAssets.pleaseInputRoomNum.showToast();
    } else {
      var aid = (model.schoolArea == StringAssets.YuntangSchoolArea)
          ? "0030000000002501"
          : "0030000000002502";
      var jsonData = JsonData(QueryElectRoomInfo(
        StringAssets.emptyStr,
        "000001",
        aid,
        Area(model.schoolArea, model.schoolArea),
        Building(model.schoolBuilding,
            Constant().getBuildingId(model.schoolBuilding)),
        Floor(StringAssets.emptyStr, StringAssets.emptyStr),
        Room(roomId, roomId),
      )).toJson();
      service?.queryElectricity(jsonEncode(jsonData), onDataSuccess: (data, _) {
        if (data is Map) {
          StringAssets.queryFailWithError.showToast();
        } else {
          StringAssets.querySuccess.showToast();
          _saveData();
          var queryJsonMap = jsonDecode(data);
          var value = queryJsonMap["query_elec_roominfo"]["errmsg"];
          model.result = model.schoolArea +
              model.schoolBuilding +
              roomId +
              value.toString().trim();
          notifyListeners();
        }
      });
    }
  }

  /// 保存数据
  void _saveData() {
    spSchoolArea.set(model.schoolArea);
    spSchoolBuilding.set(model.schoolBuilding);
    spRoom.set(model.roomController.text);
  }
}
