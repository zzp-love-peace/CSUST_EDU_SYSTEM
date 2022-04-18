import 'package:csust_edu_system/data/date_info.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/network/network.dart';
import 'package:csust_edu_system/utils/course_util.dart';
import 'package:csust_edu_system/utils/date_util.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:csust_edu_system/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class CoursePage extends StatefulWidget {
  List _courseData;

  CoursePage(this._courseData, {Key? key}) : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage>
    with SingleTickerProviderStateMixin {
  int _weekNum = DateInfo.nowWeek;
  String _term = DateInfo.nowTerm;
  late PageController _pageController;
  late List<Widget> _pageList = _initCourseLayout();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _weekNum - 1,
      keepPage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _coursePageAppBar(),
        body: PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            children: _pageList,
            onPageChanged: (index) {
              setState(() {
                _weekNum = index + 1;
              });
            }));
  }

  AppBar _coursePageAppBar() {
    return AppBar(
      elevation: 0,
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Container(
              color: Colors.white,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyDatePicker(
                    callBack: (term) {
                      _term = term;
                      try {
                        HttpManager()
                            .getAllCourse(StuInfo.token, StuInfo.cookie, _term,
                                DateInfo.totalWeek)
                            .then((value) {
                          widget._courseData =
                              CourseUtil.changeCourseDataList(value);
                          if (_term != DateInfo.nowTerm) {
                            _weekNum = 1;
                          } else {
                            _weekNum = DateInfo.nowWeek;
                          }
                          _pageController.jumpToPage(_weekNum - 1);
                          _pageList = _initCourseLayout();
                          setState(() {});
                        });
                      } on Exception {
                        SmartDialog.showToast('',
                            widget: const CustomToast('获取学期出错了'));
                      }
                    },
                  ),
                  Expanded(child: _weekBelowAppBar())
                ],
              ))),
      centerTitle: true,
      title: const Text(
        "课程表",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Stack _weekBelowAppBar() {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 90),
          child: Text(
            '第$_weekNum周',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Text(
            _weekNum == DateInfo.nowWeek && _term == DateInfo.nowTerm
                ? '本周'
                : '非本周',
            style: const TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }

  List<Widget> _initCourseLayout() {
    List<Widget> result = [];
    List<int> date = _getSunday(DateInfo.nowDate);
    for (int i = 1; i <= DateInfo.totalWeek; i++) {
      List<int> d;
      if (i < DateInfo.nowWeek) {
        d = DateUtil.minusDay(
            date[0], date[1], date[2], (DateInfo.nowWeek - i) * 7);
      } else if (i == DateInfo.nowWeek) {
        d = date;
      } else {
        d = DateUtil.addDay(
            date[0], date[1], date[2], (i - DateInfo.nowWeek) * 7);
      }
      result.add(_newCourseLayout(d[0], d[1], d[2], i - 1));
    }
    return result;
  }

  /// 传入今天的日期 格式为xxx-xx-xx 返回本周日的年月日
  List<int> _getSunday(String nowDate) {
    var date = DateUtil.splitDate(nowDate);
    int dateOfWeek = DateUtil.date2Week(nowDate);
    return DateUtil.minusDay(date[0], date[1], date[2], dateOfWeek);
  }

  Widget _newCourseLayout(int year, int month, int day, int index) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Row(
            children: _weekAboveCourseTab(
                day, month, year, _term == DateInfo.nowTerm),
          ),
        ),
        Expanded(
            child: widget._courseData.isNotEmpty
                ? GridView.count(
                    crossAxisCount: 8,
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 3.0,
                    childAspectRatio: 0.35,
                    children: _gridCourseList(index),
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 40),
                  )
                : Container())
      ],
    );
  }

  ///  dayOfSunday: 周日是多少号  monthOfSunday: 周日是多少月
  List<Widget> _weekAboveCourseTab(
      int dayOfSunday, int monthOfSunday, int yearOfSunday, bool isNowTerm) {
    List<Widget> result = [];
    List<int> today = DateUtil.splitDate(DateInfo.nowDate);
    for (int i = 0; i < 8; i++) {
      Widget widget;
      String stringOfDate;
      int date =
          DateUtil.addDay(yearOfSunday, monthOfSunday, dayOfSunday, i - 1)[2];
      if (isNowTerm) {
        stringOfDate = date.toString();
      } else {
        stringOfDate = "";
      }
      switch (i) {
        case 0:
          widget = isNowTerm
              ? _weekLayoutItem(monthOfSunday.toString(), '月', false)
              : _weekLayoutItem('', '', false);
          break;
        case 1:
          widget = _weekLayoutItem(
            '周日',
            stringOfDate,
            today[1] == monthOfSunday && today[2] == date,
          );
          break;
        case 2:
          widget = _weekLayoutItem(
            '周一',
            stringOfDate,
            today[1] == monthOfSunday && today[2] == date,
          );
          break;
        case 3:
          widget = _weekLayoutItem('周二', stringOfDate,
              today[1] == monthOfSunday && today[2] == date);
          break;
        case 4:
          widget = _weekLayoutItem('周三', stringOfDate,
              today[1] == monthOfSunday && today[2] == date);
          break;
        case 5:
          widget = _weekLayoutItem(
            '周四',
            stringOfDate,
            today[1] == monthOfSunday && today[2] == date,
          );
          break;
        case 6:
          widget = _weekLayoutItem(
            '周五',
            stringOfDate,
            today[1] == monthOfSunday && today[2] == date,
          );
          break;
        case 7:
          widget = _weekLayoutItem(
            '周六',
            stringOfDate,
            today[1] == monthOfSunday && today[2] == date,
          );
          break;
        default:
          throw Exception('这都能越界？');
      }
      result.add(widget);
    }
    return result;
  }

  Widget _weekLayoutItem(
    String title,
    String date,
    bool isToday,
  ) {
    return Expanded(
        flex: 1,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 3, 3),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: isToday ? Colors.blue.withOpacity(0.2) : Colors.transparent,
          ),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Text(title),
              Text(date),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ));
  }

  Widget _getCourseData(int index, int courseDataIndex) {
    if (index % 8 == 0) {
      int t = (index ~/ 8) * 2 + 1;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text(t.toString()), Text((t + 1).toString())],
        ),
      );
    }
    if (widget._courseData[courseDataIndex][index ~/ 8][index % 8] == null) {
      return Container();
    } else {
      int i = (DateUtil.date2Week(DateInfo.nowDate) + 1) % 8;
      var value = widget._courseData[courseDataIndex][index ~/ 8][index % 8];
      return _courseItem(
          value['courseName'],
          value['address'],
          value['teacher'],
          value['time'],
          i == (index % 8) && courseDataIndex + 1 == DateInfo.nowWeek);
    }
  }

  List<Widget> _gridCourseList(int index) {
    List<Widget> result = [];
    for (int i = 0; i < 40; i++) {
      result.add(_getCourseData(i, index));
    }
    return result;
  }

  Widget _courseItem(
      String name, String place, String teacher, String time, bool isToday) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: isToday
              ? Colors.lightBlue
              : Colors.lightBlueAccent.withOpacity(0.5)),
      child: InkWell(
        onTap: () {
          SmartDialog.show(
              widget: _courseDialog(name, place, teacher, time),
              isLoadingTemp: false);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 3,
              ),
              Text(
                name,
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '@$place',
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _courseDialog(String name, String place, String teacher, String time) {
    List splitTime = time.split('[');
    var timeOfWeek = splitTime[0];
    var timeOfDay = splitTime[1].toString().split(']')[0];
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 300,
          width: double.infinity,
          child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.date_range_outlined,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(timeOfWeek),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        color: Colors.amberAccent,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(timeOfDay),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(teacher),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.place,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(place),
                    ],
                  )
                ],
              ))),
    );
  }
}
