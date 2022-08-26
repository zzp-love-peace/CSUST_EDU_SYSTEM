import 'package:csust_edu_system/data/date_info.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/network/network.dart';
import 'package:csust_edu_system/utils/grade_util.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:csust_edu_system/widgets/date_picker.dart';
import 'package:csust_edu_system/widgets/none_lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GradeHome extends StatefulWidget {
  const GradeHome({Key? key}) : super(key: key);

  @override
  State<GradeHome> createState() => _GradeHomeState();
}

class _GradeHomeState extends State<GradeHome> {
  List _gradeList = [];
  double _point = 0;
  String _term = DateInfo.nowTerm;
  int _lastClick = 0;

  @override
  void initState() {
    super.initState();
    _queryScore(DateInfo.nowTerm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _gradePageAppBar(),
      body: _gradeCenterLayout(),
    );
  }

  AppBar _gradePageAppBar() {
    return AppBar(
      foregroundColor: Colors.white,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Container(
              color: Colors.white,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyDatePicker(callBack: (term) {
                    _queryScore(term);
                    _term = term;
                  }),
                  _pointBelowAppBar()
                ],
              ))),
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {
              var now = DateTime.now().millisecondsSinceEpoch;
              if (now - _lastClick < 1500) return;
              _lastClick = now;
              _queryScore(_term);
              SmartDialog.compatible.showToast('', widget: const CustomToast('刷新成功'));
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ))
      ],
      centerTitle: true,
      title: const Text(
        "成绩",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _pointBelowAppBar() {
    return _point == 0
        ? Container()
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '平均绩点:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  _point.toStringAsFixed(2),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(
                width: 30,
              )
            ],
          );
  }

  Widget _gradeCenterLayout() {
    return _gradeList.isNotEmpty
        ? Column(
            children: [
              Expanded(
                child: ListView(
                  children: ListTile.divideTiles(
                          context: context, tiles: _getGradeItem())
                      .toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                    child: Text(
                      'Tip:点击学科列表获取平时成绩',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              )
            ],
          )
        :   const NoneLottie(hint: '暂无数据...')
    ;
  }

  List<Widget> _getGradeItem() {
    List<Widget> result = [];
    for (var element in _gradeList) {
      result.add(ListTile(
        tileColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        leading: Icon(
          Icons.arrow_right,
          color: Colors.black.withOpacity(0.7),
          size: 36,
        ),
        title: Text(element['courseName'],
            style: const TextStyle(color: Colors.black)),
        trailing: Text(
          element['score'],
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        onTap: () {
          _queryScoreInfo(element['pscjUrl']).then((value) {
            var examData = _ExamData(
                element['courseName'],
                element['point'],
                element['method'],
                element['property'],
                element['nature'],
                element['xuefen'],
                value['pscj'] ?? '',
                value['pscjBL'] ?? '',
                value['qzcj'] ?? '',
                value['qzcjBL'] ?? '',
                value['qmcj'] ?? '',
                value['qmcjBL'] ?? '');
            SmartDialog.compatible.show(
                widget: _gradeDialog(examData), isLoadingTemp: false);
          });
        },
      ));
    }
    result.add(const SizedBox(height: 5));
    return result;
  }

  _queryScore(String term) async {
    if (StuInfo.token.isEmpty && StuInfo.cookie.isEmpty) return;
    var value =
        await HttpManager().queryScore(StuInfo.token, StuInfo.cookie, term);
    if (value.isNotEmpty) {
      if (value['code'] == 200) {
        setState(() {
          _gradeList = value['data'];
          _point = getSumPoint(_gradeList);
        });
      } else {
        SmartDialog.compatible.showToast('', widget: CustomToast(value['msg']));
        setState(() {
          _gradeList = [];
          _point = 0;
        });
      }
    } else {
      SmartDialog.compatible.showToast('', widget: const CustomToast('获取成绩异常'));
    }
  }

  Future<Map> _queryScoreInfo(String url) async {
    var result = {};
    var value =
        await HttpManager().queryScoreInfo(StuInfo.token, StuInfo.cookie, url);
    if (value.isNotEmpty) {
      if (value['code'] == 200) {
        result = value['data'];
      } else {
        SmartDialog.compatible.showToast('', widget: CustomToast(value['msg']));
      }
    } else {
      SmartDialog.compatible.showToast('', widget: const CustomToast('获取成绩异常'));
    }
    return result;
  }

  Widget _gradeDialog(_ExamData data) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 450,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  data.courseName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Row(
                  children: [
                    const Text('学分:'),
                    const SizedBox(width: 10),
                    Text(data.score)
                  ],
                ),
                Row(
                  children: [
                    const Text('绩点:'),
                    const SizedBox(width: 10),
                    Text(data.point)
                  ],
                ),
                Row(
                  children: [
                    const Text('课程性质:'),
                    const SizedBox(width: 10),
                    Text(data.property + " " + data.nature)
                  ],
                ),
                // Row(
                //   children: [
                //     const Text('考核方式:'),
                //     const SizedBox(width: 10),
                //     Text(data.method)
                //   ],
                // ),
                Row(
                  children: [
                    const Text('平时成绩:'),
                    const SizedBox(width: 10),
                    Text(data.normalGrade)
                  ],
                ),
                Row(
                  children: [
                    const Text('平时成绩比例:'),
                    const SizedBox(width: 10),
                    Text(data.normalGradePer)
                  ],
                ),
                Row(
                  children: [
                    const Text('期中成绩:'),
                    const SizedBox(width: 10),
                    Text(data.middleGrade)
                  ],
                ),
                Row(
                  children: [
                    const Text('期中成绩比例:'),
                    const SizedBox(width: 10),
                    Text(data.middleGradePer)
                  ],
                ),
                Row(
                  children: [
                    const Text('期末成绩:'),
                    const SizedBox(width: 10),
                    Text(data.finalGrade)
                  ],
                ),
                Row(
                  children: [
                    const Text('期末成绩比例:'),
                    const SizedBox(width: 10),
                    Text(data.finalGradePer)
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class _ExamData {
  // 学科名称
  final String courseName;

  // 绩点
  final String point;

  // 考试还是考查
  final String method;

  // 必修还是选修
  final String property;

  // 课程类别
  final String nature;

  // 学分
  final String score;

  // 平时成绩
  final String normalGrade;

  // 平时成绩比例
  final String normalGradePer;

  // 期中成绩
  final String middleGrade;

  // 期中成绩比例
  final String middleGradePer;

  // 期末成绩
  final String finalGrade;

  // 期末成绩比例
  final String finalGradePer;

  const _ExamData(
      this.courseName,
      this.point,
      this.method,
      this.property,
      this.nature,
      this.score,
      this.normalGrade,
      this.normalGradePer,
      this.middleGrade,
      this.middleGradePer,
      this.finalGrade,
      this.finalGradePer);
}
