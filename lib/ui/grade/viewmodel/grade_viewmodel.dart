import 'dart:convert';

import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/grade/json/db_grade_bean.dart';
import 'package:csust_edu_system/ui/grade/json/grade_bean.dart';
import 'package:csust_edu_system/ui/grade/json/grade_info_bean.dart';
import 'package:csust_edu_system/ui/grade/model/grade_model.dart';
import 'package:csust_edu_system/ui/grade/service/grade_service.dart';
import 'package:csust_edu_system/ui/grade/view/grade_dialog.dart';

import '../../../ass/string_assets.dart';
import '../../../data/stu_info.dart';
import '../../../util/grade_util.dart';
import '../db/grade_db_manager.dart';

/// 成绩ViewModel
///
/// @author wk
/// @version V1.8.8
/// @since 2023/10/28
class GradeViewModel extends BaseViewModel<GradeModel, GradeService> {
  GradeViewModel({required super.model});

  ///上一次click触发时间
  int lastClick = 0;

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
        model.point = GradeUtil.getSumPoint(model.gradeList);
        notifyListeners();
      },
      onFinish: (isSuccess) {
        if (!isSuccess) {
          GradeDBManager.getGradesOfTerm(term).then((dbValue) {
            model.gradeList = dbValue
                .map((e) => GradeBean.fromJson(jsonDecode(e.content)))
                .toList();
            model.point = GradeUtil.getSumPoint(model.gradeList);
            notifyListeners();
          });
        }
      },
    );
  }

  /// 获取成绩详情
  ///
  /// [cookie] cookie
  /// [gradeInfoUrl] 成绩详情Url
  /// [position] 列表索引
  void queryScoreInfo(String cookie, String gradeInfoUrl, int position) {
    service?.queryScoreInfo(
        cookie: cookie,
        gradeInfoUrl: gradeInfoUrl,
        onDataSuccess: (data, msg) {
          GradeInfoBean gradeInfoBean = GradeInfoBean.fromJson(data);
          GradeDialog(
            data: model.gradeList[position],
            infoData: gradeInfoBean,
          ).showDialog(clickMaskDismiss: true);
          String infoContent = jsonEncode(data);
          GradeDBManager.containsGrade(
                  model.term, model.gradeList[position].courseName)
              .then((dbValue) {
            if (dbValue != null) {
              GradeDBManager.updateGradeInfo(infoContent, dbValue.id);
            }
          });
        },
        onFinish: (isSuccess) {
          if (!isSuccess) {
            GradeInfoBean gradeInfoBean = GradeInfoBean.fromJson({});
            GradeDBManager.containsGrade(
                    model.term, model.gradeList[position].courseName)
                .then((dbValue) {
              if (dbValue != null) {
                String infoContent = dbValue.infoContent;
                if (infoContent.isNotEmpty) {
                  gradeInfoBean =
                      GradeInfoBean.fromJson(jsonDecode(dbValue.infoContent));
                }
              }
            });
            GradeDialog(
              data: model.gradeList[position],
              infoData: gradeInfoBean,
            ).showDialog(clickMaskDismiss: true);
          }
        });
  }

  /// 刷新成绩
  void refreshGrade() {
    var now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastClick < 1500) return;
    lastClick = now;
    queryScore(StuInfo.cookie, model.term);
    StringAssets.refreshSuccess.showToast();
  }
}
