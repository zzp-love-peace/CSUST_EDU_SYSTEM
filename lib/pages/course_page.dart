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

class _CoursePageState extends State<CoursePage> {
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
                    callBack: _datePickerCallback,
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
    var itemWidth = (MediaQuery.of(context).size.width - 31) / 8;
    var itemHeight = 120.0;
    var childAspectRatio = itemWidth / itemHeight;
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
                    childAspectRatio: childAspectRatio,
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
      bool isToday = today[1] == monthOfSunday &&
          today[2] == date &&
          _term == DateInfo.nowTerm;
      switch (i) {
        case 0:
          widget = isNowTerm && DateInfo.nowWeek != -1
              ? _WeekLayoutItem(
                  title: monthOfSunday.toString(), date: '月', isToday: false)
              : const _WeekLayoutItem(title: '', date: '', isToday: false);
          break;
        case 1:
          widget = _WeekLayoutItem(
            title: '周日',
            date: stringOfDate,
            isToday: isToday,
          );
          break;
        case 2:
          widget = _WeekLayoutItem(
            title: '周一',
            date: stringOfDate,
            isToday: isToday,
          );
          break;
        case 3:
          widget = _WeekLayoutItem(
              title: '周二', date: stringOfDate, isToday: isToday);
          break;
        case 4:
          widget = _WeekLayoutItem(
              title: '周三', date: stringOfDate, isToday: isToday);
          break;
        case 5:
          widget = _WeekLayoutItem(
            title: '周四',
            date: stringOfDate,
            isToday: isToday,
          );
          break;
        case 6:
          widget = _WeekLayoutItem(
            title: '周五',
            date: stringOfDate,
            isToday: isToday,
          );
          break;
        case 7:
          widget = _WeekLayoutItem(
            title: '周六',
            date: stringOfDate,
            isToday: isToday,
          );
          break;
        default:
          throw Exception('这都能越界？');
      }
      result.add(widget);
    }
    return result;
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
    int i = (DateUtil.date2Week(DateInfo.nowDate) + 1) % 8;
    bool isToday = i == (index % 8) &&
        courseDataIndex + 1 == DateInfo.nowWeek &&
        _term == DateInfo.nowTerm;
    if (widget._courseData[courseDataIndex][index ~/ 8][index % 8] == null) {
      return _TransactionItem(isToday: isToday);
    } else {
      var value = widget._courseData[courseDataIndex][index ~/ 8][index % 8];
      return _CourseItem(
          name: value['courseName'],
          place: value['address'],
          teacher: value['teacher'],
          time: value['time'],
          isToday: isToday);
    }
  }

  List<Widget> _gridCourseList(int index) {
    List<Widget> result = [];
    for (int i = 0; i < 40; i++) {
      result.add(_getCourseData(i, index));
    }
    return result;
  }

  _datePickerCallback(term) {
    _term = term;
    try {
      HttpManager()
          .getAllCourse(
              StuInfo.token, StuInfo.cookie, _term, DateInfo.totalWeek)
          .then((value) {
        widget._courseData = CourseUtil.changeCourseDataList(value);
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
      SmartDialog.showToast('', widget: const CustomToast('获取学期出错了'));
    }
  }
}

class _WeekLayoutItem extends StatelessWidget {
  final bool isToday;
  final String title;
  final String date;

  const _WeekLayoutItem(
      {Key? key,
      required this.isToday,
      required this.title,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 3, 3),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: isToday
                ? Theme.of(context).primaryColor.withOpacity(0.2)
                : Colors.transparent,
          ),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Text(title),
              Text(DateInfo.nowWeek != -1 ? date : ""),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ));
  }
}

class _CourseItem extends StatelessWidget {
  final bool isToday;
  final String name;
  final String place;
  final String teacher;
  final String time;

  const _CourseItem({
    Key? key,
    required this.isToday,
    required this.name,
    required this.place,
    required this.teacher,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: isToday
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.45)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '@$place',
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 12,
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

class _TransactionItem extends StatefulWidget {
  final bool isToday;

  const _TransactionItem({Key? key, required this.isToday}) : super(key: key);

  @override
  State<_TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<_TransactionItem> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: _isClicked
              ? Theme.of(context).primaryColor.withOpacity(0.2)
              : Colors.transparent),
      child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          onTap: () {
            return;
            if (_isClicked == false) {
              Future.delayed(const Duration(milliseconds: 5000), () {
                setState(() {
                  _isClicked = false;
                });
              });
            } else {}
            setState(() {
              _isClicked = !_isClicked;
            });
          },
          child: _isClicked
              ? const Center(
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.grey,
                  ),
                )
              : Container()
          // Padding(
          //   padding: const EdgeInsets.only(left: 2),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const SizedBox(
          //         height: 3,
          //       ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
