import 'package:csust_edu_system/data/date_info.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/network/network.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:csust_edu_system/widgets/date_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class GradePage extends StatefulWidget {
  const GradePage({Key? key}) : super(key: key);

  @override
  State<GradePage> createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  List _gradeList = [];
  double _point = 0;

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
                  }),
                  _pointBelowAppBar()
                ],
              ))),
      elevation: 0,
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text('Tip:点击学科列表获取平时成绩', style: TextStyle(fontSize: 10),),
                  SizedBox(
                    width: 10,
                  )
                ],
              )
            ],
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/no_message_grade.png'),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  '暂无数据',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          );
  }

  List<Widget> _getGradeItem() {
    List<Widget> result = [];
    for (var element in _gradeList) {
      result.add(ListTile(
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
          style: const TextStyle(color: Colors.indigoAccent),
        ),
        onTap: () {
          _queryScoreInfo(element['pscjUrl']).then((value) {
            var examData = _ExamData(
                element['courseName'],
                element['xuefen'],
                value['pscj'] ?? '',
                value['pscjBL'] ?? '',
                value['qzcj'] ?? '',
                value['qzcjBL'] ?? '',
                value['qmcj'] ?? '',
                value['qmcjBL'] ?? '');
            SmartDialog.show(
                widget: _gradeDialog(examData), isLoadingTemp: false);
          });
        },
      ));
    }
    result.add(const SizedBox(height: 5));
    return result;
  }

  double _getSumPoint() {
    double sum = 0;
    double sumPointXScore = 0;
    for (var element in _gradeList) {
      sum += double.parse(element['xuefen']);
      sumPointXScore +=
          (double.parse(element['xuefen']) * double.parse(element['point']));
    }
    return sumPointXScore / sum;
  }

  _queryScore(String term) {
    if (StuInfo.token.isEmpty && StuInfo.cookie.isEmpty) return;
    HttpManager().queryScore(StuInfo.token, StuInfo.cookie, term).then((value) {
      print(value);
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          setState(() {
            _gradeList = value['data'];
            _point = _getSumPoint();
          });
        } else {
          setState(() {
            _gradeList = [];
            _point = 0;
          });
        }
      } else {
        SmartDialog.showToast('', widget: const CustomToast('获取成绩异常'));
      }
    });
  }

  Future<Map> _queryScoreInfo(String url) async {
    var result = {};
    var value =
        await HttpManager().queryScoreInfo(StuInfo.token, StuInfo.cookie, url);
    if (value.isNotEmpty) {
      if (value['code'] == 200) {
        result = value['data'];
      }
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
          height: 400,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  data.courseName,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
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
      this.score,
      this.normalGrade,
      this.normalGradePer,
      this.middleGrade,
      this.middleGradePer,
      this.finalGrade,
      this.finalGradePer);
}
