import 'package:csust_edu_system/arch/baseview/seletor_view.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/grade/viewmodel/grade_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 成绩页AppBar
///
/// @author wk
/// @since 2023/10/28
/// @version V1.8.8
class PointBelowAppBar extends StatelessWidget {
  const PointBelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectorView<GradeViewModel, double>(
        selector: (ctx, viewModel) => viewModel.model.point,
        builder: (ctx, point, _) {
          return point == 0
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      StringAssets.averagePoint,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  point.toStringAsFixed(2),
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
              const SizedBox(
                width: 30,
              )
            ],
          );
        });
  }
}
