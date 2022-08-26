import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:csust_edu_system/widgets/select_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/course_page.dart';
import '../utils/date_util.dart';

class CourseInfoHome extends StatelessWidget {
  final int weekNum;
  final String time;
  final int index;
  final String name;
  final String teacher;
  final String place;
  final String term;
  final Function(MyCourse) saveCallback;
  final Function? deleteCallback;

  CourseInfoHome(
      {Key? key,
      required this.weekNum,
      required this.time,
      required this.saveCallback,
      required this.index,
      required this.name,
      required this.teacher,
      required this.place,
      this.deleteCallback,
      required this.term})
      : super(key: key);

  final _nameController = TextEditingController();
  final _teacherController = TextEditingController();
  final _placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = name;
    _teacherController.text = teacher;
    _placeController.text = place;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "自定义课表",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (name.isNotEmpty)
            IconButton(
                onPressed: () {
                  SmartDialog.compatible.show(
                      widget: SelectDialog(
                          title: '提示',
                          subTitle: '确定要删除该课程吗？',
                          callback: () {
                            if (deleteCallback != null) {
                              deleteCallback!();
                              Navigator.pop(context);
                            }
                          }), clickBgDismissTemp: false);
                },
                icon: const Icon(Icons.delete, color: Colors.white))
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              const Icon(Icons.edit, color: Colors.black54),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                  child: TextField(
                controller: _nameController,
                maxLines: 1,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                    hintText: '课程名称', hintStyle: TextStyle(fontSize: 16)),
              )),
              const SizedBox(
                width: 50,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              const Icon(
                Icons.person,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                  child: TextField(
                controller: _teacherController,
                maxLines: 1,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                    hintText: '授课老师', hintStyle: TextStyle(fontSize: 16)),
              )),
              const SizedBox(
                width: 50,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              const Icon(
                Icons.place,
                color: Colors.redAccent,
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                  child: TextField(
                controller: _placeController,
                maxLines: 1,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                    hintText: '上课地点', hintStyle: TextStyle(fontSize: 16)),
              )),
              const SizedBox(
                width: 50,
              ),
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              const Icon(
                Icons.date_range_outlined,
                color: Colors.green,
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                '第$weekNum周 ${DateUtil.indexToWeekDay(index % 8)}',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              const Icon(
                Icons.timer,
                color: Colors.amberAccent,
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                time,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 35, 30, 30),
            child: _saveButton(context),
          ),
        ],
      ),
    );
  }

  ElevatedButton _saveButton(context) {
    return ElevatedButton(
      child: const SizedBox(
        child: Center(
          child: Text(
            "保存",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        width: double.infinity,
      ),
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all(const EdgeInsets.fromLTRB(0, 10, 0, 10)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
      onPressed: () {
        if (_nameController.text.isEmpty) {
          SmartDialog.compatible
              .showToast('', widget: const CustomToast('课程名称不能为空'));
          return;
        }
        var course = MyCourse(_nameController.text, _placeController.text,
            _teacherController.text, '第$weekNum周[$time]', index, weekNum, term);
        Navigator.pop(context);
        saveCallback(course);
      },
    );
  }
}
