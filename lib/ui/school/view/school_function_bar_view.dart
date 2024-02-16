import 'package:csust_edu_system/arch/baseview/consumer_view.dart';
import 'package:csust_edu_system/ass/image_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/common/functionswicher/viewmodel/function_switcher_view_model.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/association/page/association_page.dart';
import 'package:csust_edu_system/ui/electricity/page/electricity_page.dart';
import 'package:csust_edu_system/ui/exam/page/exam_page.dart';
import 'package:csust_edu_system/ui/grade/page/grade_page.dart';
import 'package:csust_edu_system/ui/recruit/page/recruit_page.dart';
import 'package:csust_edu_system/ui/telephonecard/page/telephone_page.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';


/// 校园功能栏View
///
/// @author zzp
/// @since 2023/10/1
/// @version v1.8.8
class SchoolFunctionBarView extends StatelessWidget {
  const SchoolFunctionBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(Icons.functions),
              SizedBox(
                width: 12,
              ),
              Text(
                StringAssets.mainFunction,
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              _functionItem(StringAssets.queryGrade, ImageAssets.imgGrade, () {
                context.push(const GradePage());
              }),
              _functionItem(StringAssets.examArrangement, ImageAssets.imgExam,
                      () {
                        context.push(const ExamPage());
              }),
              _functionItem(
                  StringAssets.queryElectricity, ImageAssets.imgElectricity,
                      () {
                    context.push(const ElectricityPage());
                  }),
            ],
          ),
          Row(
            children: [
              _functionItem(StringAssets.schoolMap, ImageAssets.imgMap, () {
                var mapImages = [
                  ImageAssets.schoolMap1,
                  ImageAssets.schoolMap2
                ];
                context.pushWithFadeRoute(
                  PhotoViewGallery.builder(
                    itemCount: mapImages.length,
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        onTapUp: (context, details, controllerValue) {
                          context.pop();
                        },
                        imageProvider: AssetImage(mapImages[index]),
                      );
                    },
                  ),
                );
              }),
              _functionItem(StringAssets.schoolGroup, ImageAssets.imgGroup, () {
                context.push(const AssociationPage());
              }),
              ConsumerView<FunctionSwitcherViewModel>(
                builder: (ctx, viewModel, _) {
                  return viewModel.model.functionSwitcherBean.serviceHall
                      ? _functionItem(
                          StringAssets.serviceHall, ImageAssets.imgServiceHall,
                          () {
                          context.push(const TelephonePage());
                        })
                      : _functionItem(
                          StringAssets.workInformation, ImageAssets.imgWork,
                          () {
                          context.push(const RecruitPage());
                        });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  /// 功能栏item
  ///
  /// [label] 标题
  /// [path] 图片路径
  /// [tapCallback] 点击回调
  Widget _functionItem(String label, String path, Function tapCallback) {
    return Expanded(
      flex: 1,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Image.asset(
              path,
              width: 24,
              height: 24,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(label),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
        onTap: () {
          tapCallback();
        },
      ),
    );
  }
}
