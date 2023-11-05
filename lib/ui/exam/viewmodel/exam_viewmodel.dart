import 'dart:convert';

import 'package:csust_edu_system/arch/baseviewmodel/base_view_model.dart';
import 'package:csust_edu_system/ext/string_extension.dart';
import 'package:csust_edu_system/ui/exam/jsonbean/exam_bean.dart';
import 'package:csust_edu_system/ui/exam/model/exam_model.dart';
import 'package:csust_edu_system/ui/exam/service/exam_service.dart';

import '../../../ass/string_assets.dart';
import '../../../data/stu_info.dart';
import '../db/exam_db_manager.dart';
import '../jsonbean/db_exam_bean.dart';

/// 考试ViewModel
///
/// @author wk
/// @since 2023/11/4
/// @version v1.8.8
class ExamViewModel extends BaseViewModel<ExamModel, ExamService> {
  ExamViewModel({required super.model});

  /// 上一次click触发时间
  int lastClick = 0;

  @override
  ExamService? createService() => ExamService();

  /// 获取成绩列表
  ///
  /// [cookie] cookie
  /// [term] 学期
  void queryExam(String cookie, String term) {
    service?.queryExam(
        cookie: cookie,
        term: term,
        onDataSuccess: (data, msg) {
          model.examList = data.map((json) {
            String content = jsonEncode(json);
            ExamBean examBean = ExamBean.fromJson(json);
            ExamDBManager.containsExam(term, examBean.examName).then((dbValue) {
              if (dbValue == null) {
                ExamDBManager.insertExam(
                    DBExamBean(term, examBean.examName, content));
              } else {
                ExamDBManager.updateExam(content, dbValue.id);
              }
            });
            return examBean;
          }).toList();
          notifyListeners();
        },
        onFinish: (isSuccess) {
          if (!isSuccess) {
            ExamDBManager.getExamsOfTerm(term).then((dbValue) {
              model.examList = dbValue
                  .map((e) => ExamBean.fromJson(jsonDecode(e.content)))
                  .toList();
              notifyListeners();
            });
          }
        });
  }

  /// 刷新考试
  void refreshExam() {
    var now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastClick < 1500) return;
    lastClick = now;
    queryExam(StuInfo.cookie, model.term);
    StringAssets.refreshSuccess.showToast();
  }
}
