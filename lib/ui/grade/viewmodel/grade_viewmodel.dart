import 'dart:convert';

import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ui/grade/json/db_grade_bean.dart';
import 'package:csust_edu_system/ui/grade/json/grade_bean.dart';
import 'package:csust_edu_system/ui/grade/json/grade_info_bean.dart';
import 'package:csust_edu_system/ui/grade/model/grade_model.dart';
import 'package:csust_edu_system/ui/grade/service/grade_service.dart';
import 'package:csust_edu_system/ui/grade/view/grade_dialog.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../util/grade_util.dart';
import '../db/grade_db_manager.dart';

/// 成绩ViewModel
///
/// @author wk
/// @version V1.8.8
/// @since 2023/10/28
class GradeViewModel extends BaseViewModel<GradeModel, GradeService> {
  GradeViewModel({required super.model});

  @override
  GradeService? createService() => GradeService();

  /// 获取成绩列表
  ///
  /// [cookie] cookie
  /// [term] 学期
  void queryScore(String cookie, String term) {
    service?.queryScore(
      cookie: cookie,
      term: term,
      onDataSuccess: (data, msg) {
        model.gradeList = data.map((json) {
          String content = jsonEncode(json);
          GradeBean gradeBean = GradeBean.fromJson(json);
          GradeDBManager.containsGrade(term, gradeBean.courseName)
              .then((dbValue) {
            if (dbValue == null) {
              GradeDBManager.insertGrade(
                  DBGradeBean(term, gradeBean.courseName, content));
            } else {
              GradeDBManager.updateGrade(content, dbValue.id);
            }
          });
          return gradeBean;
        }).toList();
        model.point = getSumPoint(model.gradeList);
        notifyListeners();
      },
      onFinish: (isSuccess) async {
        if (!isSuccess) {
          List<DBGradeBean> dbValue =
              await GradeDBManager.getGradesOfTerm(term);
          List<GradeBean> gradeList = [];
          for (var element in dbValue) {
            GradeBean gradeBean =
                GradeBean.fromJson(jsonDecode(element.content));
            gradeList.add(gradeBean);
          }
          model.gradeList = gradeList;
          model.point = getSumPoint(model.gradeList);
          notifyListeners();
        }
      },
    );
  }

  /// 获取成绩详情
  ///
  /// [cookie] cookie
  /// [pscjUrl] pscjUrl
  /// [position] 列表索引
  void queryScoreInfo(String cookie, String pscjUrl, int position) {
    service?.queryScoreInfo(
        cookie: cookie,
        pscjUrl: pscjUrl,
        onDataSuccess: (data, msg) async {
          GradeInfoBean gradeInfoBean = GradeInfoBean.fromJson(data);
          SmartDialog.show(
              builder: (_) => GradeDialog(
                    data: model.gradeList[position],
                    infoData: gradeInfoBean,
                  ));
          String infoContent = jsonEncode(data);
          var dbValue = await GradeDBManager.containsGrade(
              model.term, model.gradeList[position].courseName);
          if (dbValue != null) {
            await GradeDBManager.updateGradeInfo(infoContent, dbValue.id);
          }
        },
        onFinish: (isSuccess) async {
          if (!isSuccess) {
            GradeInfoBean gradeInfoBean = GradeInfoBean.fromJson({});
            var dbValue = await GradeDBManager.containsGrade(
                model.term, model.gradeList[position].courseName);
            if (dbValue != null) {
              String infoContent = dbValue.infoContent;
              if (infoContent.isNotEmpty) {
                gradeInfoBean =
                    GradeInfoBean.fromJson(jsonDecode(dbValue.infoContent));
              }
            }
            SmartDialog.show(
                builder: (_) => GradeDialog(
                      data: model.gradeList[position],
                      infoData: gradeInfoBean,
                    ));
          }
        });
  }
}
