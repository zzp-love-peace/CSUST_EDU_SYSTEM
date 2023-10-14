import 'package:csust_edu_system/arch/baseview/seletor_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/ui/electricity/model/electricity_model.dart';
import 'package:csust_edu_system/ui/electricity/view/electricity_selector_view.dart';
import 'package:csust_edu_system/ui/electricity/viewmodel/electricity_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/electricity_data.dart';
import '../data/electricity_school_data.dart';

/// 查电费页
///
/// @author zzp
/// @since 2023/10/13
/// @version v1.8.8
class ElectricityPage extends StatelessWidget {
  const ElectricityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ElectricityViewModel(model: ElectricityModel()),
      child: const ElectricityHome(),
    );
  }
}

/// 查电费页Home
///
/// @author zzp
/// @since 2023/10/13
/// @version v1.8.8
class ElectricityHome extends StatelessWidget {
  const ElectricityHome({super.key});

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<ElectricityViewModel>();
    viewModel.initData();
    return Scaffold(
      appBar: CommonAppBar.create(StringAssets.queryElectricity),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SelectorView<ElectricityViewModel, String>(
            selector: (ctx, viewModel) => viewModel.model.schoolArea,
            builder: (ctx, schoolArea, _) => ElectricitySelectorView(
              title: StringAssets.schoolArea,
              content: schoolArea,
              paddingLeft: 60,
              onTap: () {
                viewModel.model.schoolAreaPicker.showPicker(
                  context,
                  title: StringAssets.selectSchoolArea,
                  initIndex: schoolAreaList.indexOf(schoolArea),
                  pickerData: schoolAreaList,
                  onConfirm: (schoolArea, index) {
                    viewModel.setSchoolArea(schoolArea);
                  },
                );
              },
            ),
          ),
          const Divider(
              thickness: 1, indent: 30, endIndent: 30, color: Colors.black12),
          SelectorView<ElectricityViewModel, String>(
            selector: (ctx, viewModel) => viewModel.model.schoolBuilding,
            builder: (ctx, schoolBuilding, _) => ElectricitySelectorView(
              title: StringAssets.schoolBuilding,
              content: schoolBuilding,
              paddingLeft: 42,
              onTap: () {
                viewModel.model.schoolBuildingPicker.showPicker(
                  context,
                  title: StringAssets.selectSchoolBuilding,
                  initIndex:
                      Constant().getAllBuildingName().indexOf(schoolBuilding),
                  pickerData: Constant().getAllBuildingName(),
                  onConfirm: (schoolBuilding, index) {
                    viewModel.setSchoolBuilding(schoolBuilding);
                  },
                );
              },
            ),
          ),
          const Divider(
              thickness: 1, indent: 30, endIndent: 30, color: Colors.black12),
          const SizedBox(
            height: 2,
          ),
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              const Text(
                StringAssets.roomNumber,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(
                width: 42,
              ),
              Expanded(
                child: TextField(
                  controller: viewModel.model.roomController,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                      hintText: StringAssets.roomNumberInputHint,
                      hintStyle: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Text(
              StringAssets.queryElectricityTips,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: _queryButton(onPressed: () {
              viewModel.doQueryElectricity();
            }),
          ),
          SelectorView<ElectricityViewModel, String>(
            selector: (ctx, viewModel) => viewModel.model.result,
            builder: (ctx, result, _) => Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Text(
                result,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 查询按钮
  ///
  /// [onPressed] 点击事件回调
  ElevatedButton _queryButton({required Function onPressed}) {
    return ElevatedButton(
      child: const SizedBox(
        child: Center(
          child: Text(
            StringAssets.query,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        width: double.infinity,
      ),
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 10, 0, 10)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
      onPressed: () {
        onPressed.call();
      },
    );
  }
}
