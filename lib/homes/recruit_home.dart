import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/homes/rec_info_home.dart';
import 'package:csust_edu_system/network/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../widgets/custom_toast.dart';
import '../widgets/none_lottie.dart';

class RecruitHome extends StatefulWidget {
  const RecruitHome({Key? key}) : super(key: key);

  @override
  State<RecruitHome> createState() => _RecruitHomeState();
}

class _RecruitHomeState extends State<RecruitHome> {
  List<Recruit> _recruitList = [];

  @override
  void initState() {
    super.initState();
    _getAllRecruitInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: AnimatedSearchBar(
            label: "兼职",
            searchStyle: const TextStyle(
              color: Colors.white,
            ),
            searchDecoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '例如家教、摄影等',
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                _getRecruitInfoByTitle(value);
              } else {
                _getAllRecruitInfo();
              }
            },
          ),
        ),
        body: _recruitList.isNotEmpty
            ? ListView.builder(
                itemCount: _recruitList.length,
                itemBuilder: (context, index) =>
                    _recruitItem(_recruitList[index]))
            : const NoneLottie(
                hint: '暂无信息...',
              ));
  }

  Widget _recruitItem(Recruit recruit) {
    return Ink(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RecInfoHome(recruit: recruit)));
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 15, 20),
              child: Text(
                recruit.title,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              child: Text(
                recruit.content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            const Icon(
              Icons.arrow_right,
              color: Colors.black,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  _getAllRecruitInfo() {
    HttpManager().getAllRecruitInfo(StuInfo.token).then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          setState(() {
            List data = value['data'];
            _recruitList = data.map((e) => Recruit.fromJson(e)).toList();
          });
        } else {
          SmartDialog.compatible
              .showToast('', widget: CustomToast(value['msg']));
        }
      } else {
        SmartDialog.compatible
            .showToast('', widget: const CustomToast('出现异常了'));
      }
    }, onError: (_) {
      SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了'));
    });
  }

  _getRecruitInfoByTitle(String title) {
    HttpManager().getRecruitInfoByTitle(StuInfo.token, title).then((value) {
      if (value.isNotEmpty) {
        print(value);
        if (value['code'] == 200) {
          setState(() {
            List data = value['data'];
            _recruitList = data.map((e) => Recruit.fromJson(e)).toList();
          });
        } else {
          SmartDialog.compatible
              .showToast('', widget: CustomToast(value['msg']));
        }
      } else {
        SmartDialog.compatible
            .showToast('', widget: const CustomToast('出现异常了'));
      }
    }, onError: (_) {
      SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了'));
    });
  }
}

class Recruit {
  late String title;
  late String content;
  late String workDate;
  late String workTime;
  late String contact;
  late String duty;

  Recruit.fromJson(Map json) {
    title = json['title'];
    content = json['content'];
    workDate = json['workDate'];
    workTime = json['workTime'];
    contact = json['contact'];
    duty = json['duty'];
  }
}
