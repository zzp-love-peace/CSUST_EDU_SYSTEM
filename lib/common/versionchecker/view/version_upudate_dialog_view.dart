import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/common/dialog/base_dialog.dart';
import 'package:csust_edu_system/common/versionchecker/model/version_update_dialog_model.dart';
import 'package:csust_edu_system/common/versionchecker/viewmodel/version_checker_view_model.dart';
import 'package:csust_edu_system/common/versionchecker/viewmodel/version_update_dialog_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ass/string_assets.dart';

/// 版本更新Dialog View
///
/// @author zzp
/// @since 2023/10/24
/// @version v1.8.8
class VersionUpdateDialogView extends StatefulWidget with BaseDialog {
  const VersionUpdateDialogView({super.key});

  @override
  State<VersionUpdateDialogView> createState() =>
      _VersionUpdateDialogViewState();
}

class _VersionUpdateDialogViewState extends State<VersionUpdateDialogView> {
  /// 版本检查ViewModel
  late final VersionCheckerViewModel versionCheckerViewModel;

  @override
  void initState() {
    super.initState();
    versionCheckerViewModel = context.read<VersionCheckerViewModel>();
  }

  @override
  void dispose() {
    versionCheckerViewModel
        .unregisterSonViewModel(KeyAssets.versionUpdateDialogViewModel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          VersionUpdateDialogViewModel(model: VersionUpdateDialogModel()),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ConsumerView<VersionUpdateDialogViewModel>(
                builder: (ctx, viewModel, _) {
                  versionCheckerViewModel.registerSonViewModel(
                      KeyAssets.versionUpdateDialogViewModel, viewModel);
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(StringAssets.updating,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 20,
                      ),
                      LinearProgressIndicator(
                        value: viewModel.model.curProgress / 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${viewModel.model.curProgress}%',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
