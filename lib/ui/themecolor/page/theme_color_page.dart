import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/common/appbar/common_app_bar.dart';
import 'package:csust_edu_system/ui/themecolor/model/theme_color_model.dart';
import 'package:csust_edu_system/ui/themecolor/viewmodel/theme_color_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ass/string_assets.dart';

/// 主题色页面
///
/// @author zzp
/// @since 2023/10/9
/// @version v1.8.8
class ThemeColorPage extends StatelessWidget {
  const ThemeColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeColorViewModel(model: ThemeColorModel()),
      child: const ThemeColorHome(),
    );
  }
}

/// 主题色页Home
///
/// @author zzp
/// @since 2023/10/9
/// @version v1.8.8
class ThemeColorHome extends StatelessWidget {
  const ThemeColorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.create(StringAssets.themeColor),
      body: ConsumerView<ThemeColorViewModel>(
        onInit: (viewModel) {
          viewModel.initData();
        },
        builder: (ctx, viewModel, _) {
          return ListView.builder(
            itemCount: viewModel.model.colors.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  viewModel.setGroupValueByIndex(index);
                },
                child: Padding(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            color: viewModel.model.colors[index],
                            width: 35,
                            height: 35,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          viewModel.model.colorNames[index],
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Radio(
                              activeColor: viewModel.model.colors[index],
                              value: viewModel.model.colorNames[index],
                              groupValue: viewModel.model.groupValue,
                              onChanged: (value) {
                                viewModel.setGroupValue(value);
                              }),
                        ),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.only(top: 10),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
