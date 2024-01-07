import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/data/page_result_code.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/stuinfo/view/head_img_row.dart';
import 'package:csust_edu_system/ui/stuinfo/view/stu_info_list_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../arch/basedata/page_result_bean.dart';
import '../../../arch/baseview/seletor_view.dart';
import '../model/stu_info_model.dart';
import '../viewmodel/stu_info_viewmodel.dart';

/// 个人资料Page
///
/// @author wk
/// @since 2023/11/26
/// @version v1.8.8
class StuInfoPage extends StatelessWidget {
  const StuInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => StuInfoViewModel(
              model: StuInfoModel(
                  userName: StuInfo.username,
                  sex: StuInfo.sex,
                  avatar: StuInfo.avatar))),
    ], child: const StuInfoHome());
  }
}

/// 个人资料Home
///
/// @author wk
/// @since 2023/11/26
/// @version v1.8.8
class StuInfoHome extends StatelessWidget {
  const StuInfoHome({super.key});

  @override
  Widget build(BuildContext context) {
    StuInfoViewModel stuInfoViewModel =
        context.readViewModel<StuInfoViewModel>();
    return WillPopScope(
      child: Scaffold(
        appBar: CommonAppBar.create(
          StringAssets.stuInfo,
          actions: [
            IconButton(
                onPressed: () {
                  stuInfoViewModel.refreshStuInfo(StuInfo.cookie);
                },
                icon: const Icon(Icons.refresh, color: Colors.white)),
          ],
        ),
        body: ListView(
          children: ListTile.divideTiles(context: context, tiles: [
            const HeadImgRow(),
            SelectorView<StuInfoViewModel, String>(
                selector: (ctx, viewModel) => viewModel.model.userName,
                builder: (ctx, userName, _) {
                  return StuInfoListTile(
                    leading: StringAssets.userName,
                    trailing: userName,
                    onPress: stuInfoViewModel.changeUserName,
                  );
                }),
            SelectorView<StuInfoViewModel, bool>(
                selector: (ctx, viewModel) => viewModel.model.sex,
                onInit: (ctx) {
                  stuInfoViewModel.model.pickerIndex = StuInfo.sex ? 0 : 1;
                },
                builder: (ctx, sex, _) {
                  return StuInfoListTile(
                    leading: StringAssets.sex,
                    trailing: stuInfoViewModel.model.sex
                        ? StringAssets.man
                        : StringAssets.woman,
                    onPress: stuInfoViewModel.selectSex,
                  );
                }),
            StuInfoListTile(leading: StringAssets.name, trailing: StuInfo.name),
            StuInfoListTile(
                leading: StringAssets.stuId, trailing: StuInfo.stuId),
            StuInfoListTile(
                leading: StringAssets.college, trailing: StuInfo.college),
            StuInfoListTile(
                leading: StringAssets.major, trailing: StuInfo.major),
            StuInfoListTile(
                leading: StringAssets.className, trailing: StuInfo.className),
            SelectorView<StuInfoViewModel, double>(
                selector: (ctx, viewModel) => viewModel.model.totalPoint,
                onInit: (ctx) {
                  stuInfoViewModel.getTotalPoint();
                },
                builder: (ctx, totalPoint, _) {
                  return StuInfoListTile(
                      leading: StringAssets.totalPoint,
                      trailing:
                          stuInfoViewModel.model.totalPoint.toStringAsFixed(2));
                }),
            SelectorView<StuInfoViewModel, bool>(
                selector: (ctx, viewModel) => viewModel.model.enable,
                builder: (ctx, enable, _) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(50, 20, 50, 30),
                    child: ElevatedButton(
                      child: const Center(
                        child: Text(
                          StringAssets.save,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      style: ButtonStyle(
                        enableFeedback: enable,
                        backgroundColor: MaterialStateProperty.all(enable
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(0, 10, 0, 10)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                      ),
                      onPressed: () {
                        if (enable) {
                          stuInfoViewModel.changeStuInfo();
                        }
                      },
                    ),
                  );
                }),
          ]).toList(),
        ),
      ),
      onWillPop: () {
        context.pop<StuInfoModel>(
            result: PageResultBean(
                PageResultCode.stuInfoChange, stuInfoViewModel.model));
        return Future.value(false);
      },
    );
  }
}
