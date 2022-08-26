import 'dart:convert';

import 'package:csust_edu_system/data/date_info.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/homes/theme_home.dart';
import 'package:csust_edu_system/network/network.dart';
import 'package:csust_edu_system/utils/course_util.dart';
import 'package:csust_edu_system/utils/date_util.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:csust_edu_system/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homes/course_info_home.dart';
import '../homes/notification_home.dart';

List<MyCourse> myCourseList = [];
late SharedPreferences prefs;

class CoursePage extends StatefulWidget {
  List _courseData;

  CoursePage(this._courseData, {Key? key}) : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  int _weekNum = DateInfo.nowWeek > 0 ? DateInfo.nowWeek : 1;
  String _term = DateInfo.nowTerm;
  late PageController _pageController;
  late List<Widget> _pageList = _initCourseLayout();
  final List _weekList = [];
  List<int> _pickerIndex = [0];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _weekNum - 1,
      keepPage: true,
    );
    if (DateInfo.nowWeek > 0) {
      _pickerIndex = [DateInfo.nowWeek - 1];
    }
    _initMyCourseList();
    if (_weekList.isEmpty) {
      for (int i = 1; i <= DateInfo.totalWeek; i++) {
        _weekList.add('第$i周');
      }
    }
    if (widget._courseData.isEmpty) {
      // _getAllCourseOfTerm(_term);
      _getAllCourseOfTerm(DateInfo.nowTerm);
    }
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
              _pickerIndex = [index];
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
                children: [
                  Expanded(
                    flex: 4,
                    child: MyDatePicker(
                      callBack: _datePickerCallback,
                    ),
                  ),
                  Expanded(flex: 3, child: _weekBelowAppBar())
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
      actions: [
        if (widget._courseData.isEmpty)
          IconButton(
            onPressed: () {
              // _getAllCourseOfTerm(_term);
              _getAllCourseOfTerm(DateInfo.nowTerm);
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ThemeHome()));
          },
          icon: const Icon(
            Icons.color_lens,
            color: Colors.white,
          ),
        )
      ],
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const NotificationHome()));
        },
        icon: const Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _weekBelowAppBar() {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: InkWell(
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  Text(
                    '第$_weekNum周',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.black),
                ],
              ),
              onTap: () {
                Picker(
                    title: const Text(
                      '选择周数',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    confirmText: '确定',
                    cancelText: '取消',
                    selecteds: _pickerIndex,
                    adapter: PickerDataAdapter<String>(pickerdata: _weekList),
                    changeToFirst: true,
                    hideHeader: false,
                    onConfirm: (Picker picker, List value) {
                      setState(() {
                        var week = picker.adapter.text
                            .substring(1, picker.adapter.text.length - 1);
                        _weekNum = _weekList.indexOf(week) + 1;
                        _pageController.animateToPage(_weekNum - 1,
                            duration: const Duration(milliseconds: 1200),
                            curve: Curves.fastOutSlowIn);
                        _pickerIndex = [value[0]];
                      });
                    }).showModal(context);
              },
            )),
        Expanded(
          flex: 1,
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
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
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
    if (widget._courseData[courseDataIndex][index ~/ 8][index % 8] != null) {
      var value = widget._courseData[courseDataIndex][index ~/ 8][index % 8];
      return _CourseItem(
        name: value['courseName'],
        time: value['time'],
        isToday: isToday,
        place: value['address'],
        teacher: value['teacher'],
        isMine: false,
        index: index,
        weekNum: courseDataIndex + 1,
        term: _term,
      );
    } else {
      int start = (index ~/ 8 + 1) * 2 - 1;
      int end = (index ~/ 8 + 1) * 2;
      String startStr = start < 10 ? '0$start' : start.toString();
      String endStr = end < 10 ? '0$end' : end.toString();
      return _TransactionItem(
        isToday: isToday,
        index: index,
        weekNum: courseDataIndex + 1,
        time: '$startStr-$endStr节',
        term: _term,
      );
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
    HttpManager()
        .getAllCourse(StuInfo.token, StuInfo.cookie, _term, DateInfo.totalWeek)
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
    }, onError: (_) {
      // _getAllCourseOfTerm(_term);
      SmartDialog.compatible
          .showToast('', widget: const CustomToast('获取课表出错了'));
    });
  }

  _initMyCourseList() async {
    prefs = await SharedPreferences.getInstance();
    String myCourseData = prefs.getString('myCourseData') ?? '';
    List list;
    try {
      list = jsonDecode(myCourseData);
    } on FormatException {
      list = [];
    }
    myCourseList = list.map((e) => MyCourse.fromJson(e)).toList();
  }

  _getAllCourseOfTerm(String term) {
    Future.delayed(const Duration(milliseconds: 100), (){
      HttpManager()
          .getAllCourseOfTerm(StuInfo.cookie, StuInfo.token, term)
          .then((value) {
        if (value.isNotEmpty) {
          if (value['code'] == 200) {
            List data = value['data'];
            List allData = CourseUtil.analyzeCourseOfTerm(data);
            setState(() {
              print("sdasdsa");
              widget._courseData = CourseUtil.changeCourseDataList(allData);
              _pageList = _initCourseLayout();
            });
            if (_term == DateInfo.nowTerm) {
              prefs.setString('courseData_exception', jsonEncode(allData));
            }
          } else {
            SmartDialog.compatible
                .showToast('', widget: const CustomToast('获取课表出错了'));
            if (_term == DateInfo.nowTerm) {
              var jsonData = prefs.getString('courseData_exception') ?? '';
              if (jsonData.isNotEmpty) {
                List courseData = jsonDecode(jsonData);
                setState(() {
                  widget._courseData = CourseUtil.changeCourseDataList(courseData);
                  _pageList = _initCourseLayout();
                });
              }
            }
          }
        } else {
          SmartDialog.compatible.showToast('', widget: const CustomToast('出异常了'));
          if (_term == DateInfo.nowTerm) {
            var jsonData = prefs.getString('courseData_exception') ?? '';
            if (jsonData.isNotEmpty) {
              List courseData = jsonDecode(jsonData);
              setState(() {
                widget._courseData = CourseUtil.changeCourseDataList(courseData);
                _pageList = _initCourseLayout();
              });
            }
          }
        }
      }, onError: (_) {
        SmartDialog.compatible.showToast('', widget: const CustomToast('出异常了'));
      });
    });
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

class _CourseItem extends StatefulWidget {
  final bool isToday;
  final String name;
  final String place;
  final String teacher;
  final String time;
  final bool isMine;
  final int index;
  final int weekNum;
  final String term;
  final Function? deleteCallback;

  const _CourseItem({
    Key? key,
    required this.isToday,
    required this.name,
    required this.place,
    required this.teacher,
    required this.time,
    required this.isMine,
    required this.index,
    required this.weekNum,
    this.deleteCallback,
    required this.term,
  }) : super(key: key);

  @override
  State<_CourseItem> createState() => _CourseItemState();
}

class _CourseItemState extends State<_CourseItem> {
  late String _name;
  late String _teacher;
  late String _place;

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _teacher = widget.teacher;
    _place = widget.place;
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: widget.isToday
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.45)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: () {
          if (widget.isMine) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CourseInfoHome(
                      weekNum: widget.weekNum,
                      time: widget.time,
                      index: widget.index,
                      name: _name,
                      teacher: _teacher,
                      place: _place,
                      term: widget.term,
                      saveCallback: (course) {
                        setState(() {
                          _name = course.name;
                          _place = course.place;
                          _teacher = course.teacher;
                        });
                      },
                      deleteCallback: () {
                        if (widget.deleteCallback != null) {
                          widget.deleteCallback!();
                        }
                      },
                    )));
          } else {
            SmartDialog.compatible.show(
                widget: _courseDialog(
                    widget.name, widget.place, widget.teacher, widget.time),
                isLoadingTemp: false);
          }
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
                _name,
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '@$_place',
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
                    Expanded(
                      child: Text(teacher),
                    ),
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
                    Expanded(
                      child: Text(place),
                    )
                  ],
                )
              ],
            ))),
  );
}

class _TransactionItem extends StatefulWidget {
  final bool isToday;
  final int index;
  final int weekNum;
  final String time;
  final String term;

  const _TransactionItem(
      {Key? key,
      required this.isToday,
      required this.index,
      required this.weekNum,
      required this.time,
      required this.term})
      : super(key: key);

  @override
  State<_TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<_TransactionItem> {
  bool _isClicked = false;

  String _name = '';
  String _place = '';
  String _teacher = '';
  String _time = '';

  bool _isCourse = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1), () {
      for (var course in myCourseList) {
        if (widget.term == course.term &&
            widget.index == course.index &&
            widget.weekNum == course.weekNum) {
          setState(() {
            _name = course.name;
            _place = course.place;
            _time = course.time;
            _teacher = course.teacher;
            _isCourse = true;
          });
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isCourse
        ? _CourseItem(
            isToday: widget.isToday,
            name: _name,
            place: _place,
            teacher: _teacher,
            time: _time,
            isMine: true,
            index: widget.index,
            weekNum: widget.weekNum,
            term: widget.term,
            deleteCallback: () {
              for (int i = 0; i < myCourseList.length; i++) {
                if (widget.term == myCourseList[i].term &&
                    widget.index == myCourseList[i].index &&
                    widget.weekNum == myCourseList[i].weekNum) {
                  myCourseList.removeAt(i);
                  break;
                }
              }
              List list = myCourseList.map((e) => e.toJson()).toList();
              String jsonData = jsonEncode(list);
              prefs.setString('myCourseData', jsonData);
              setState(() {
                _isCourse = false;
                _name = '';
                _place = '';
                _teacher = '';
              });
            },
          )
        : Ink(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: _isClicked
                    ? Theme.of(context).primaryColor.withOpacity(0.2)
                    : Colors.transparent),
            child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                onTap: () {
                  // return;
                  if (_isClicked == false) {
                    Future.delayed(const Duration(milliseconds: 3000), () {
                      if (mounted) {
                        setState(() {
                          _isClicked = false;
                        });
                      }
                    });
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CourseInfoHome(
                              weekNum: widget.weekNum,
                              time: widget.time,
                              index: widget.index,
                              name: _name,
                              teacher: _teacher,
                              place: _place,
                              term: widget.term,
                              saveCallback: (course) {
                                myCourseList.add(course);
                                List list = myCourseList
                                    .map((e) => e.toJson())
                                    .toList();
                                String jsonData = jsonEncode(list);
                                prefs.setString('myCourseData', jsonData);
                                setState(() {
                                  _name = course.name;
                                  _place = course.place;
                                  _teacher = course.teacher;
                                  _time = course.time;
                                  _isCourse = true;
                                });
                              },
                            )));
                  }
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

class MyCourse {
  late String name;
  late String place;
  late String teacher;
  late String time;
  late int index;
  late int weekNum;
  late String term;

  MyCourse(this.name, this.place, this.teacher, this.time, this.index,
      this.weekNum, this.term);

  MyCourse.fromJson(Map json) {
    name = json['name'];
    place = json['place'];
    teacher = json['teacher'];
    time = json['time'];
    index = json['index'];
    weekNum = json['weekNum'];
    term = json['term'];
  }

  Map toJson() {
    Map map = {};
    map['name'] = name;
    map['place'] = place;
    map['teacher'] = teacher;
    map['time'] = time;
    map['index'] = index;
    map['weekNum'] = weekNum;
    map['term'] = term;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyCourse &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          place == other.place &&
          teacher == other.teacher &&
          time == other.time &&
          index == other.index &&
          weekNum == other.weekNum &&
          term == other.term;

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + name.hashCode;
    result = 37 * result + place.hashCode;
    result = 37 * result + teacher.hashCode;
    result = 37 * result + time.hashCode;
    result = 37 * result + index.hashCode;
    result = 37 * result + weekNum.hashCode;
    result = 37 * result + term.hashCode;
    return result;
  }
}
