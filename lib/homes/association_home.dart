import 'package:cached_network_image/cached_network_image.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/homes/ass_info_home.dart';
import 'package:csust_edu_system/network/network.dart';
import 'package:csust_edu_system/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../utils/my_util.dart';

class AssociationHome extends StatefulWidget {
  const AssociationHome({Key? key}) : super(key: key);

  @override
  State<AssociationHome> createState() => _AssociationHomeState();
}

class _AssociationHomeState extends State<AssociationHome> {
  List<Widget> _tabList = [];
  List<Widget> _tabPages = [];

  @override
  void initState() {
    super.initState();
    _getAssTabs();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabList.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "社团",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            labelStyle: const TextStyle(fontSize: 16),
            tabs: _tabList,
            isScrollable: true,
          ),
        ),
        body: TabBarView(children: _tabPages),
      ),
    );
  }

  _getAssTabs() {
    HttpManager().getAssTabs(StuInfo.token).then((value) {
      if (value.isNotEmpty) {
        print(value);
        if (value['code'] == 200) {
          setState(() {
            List tabs = value['data'];
            _tabList = tabs.map((e) => Tab(text: e['categoryName'])).toList();
            _tabPages = tabs.map((e) => _AssList(id: e['id'])).toList();
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

class _AssList extends StatefulWidget {
  final int id;

  const _AssList({Key? key, required this.id}) : super(key: key);

  @override
  State<_AssList> createState() => _AssListState();
}

class _AssListState extends State<_AssList> {
  List<AssInfo> _infoList = [];

  @override
  void initState() {
    super.initState();
    _getAssById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _infoList.length,
        itemBuilder: (context, index) => _assItem(_infoList[index]));
  }

  _getAssById(int id) {
    HttpManager().getAssByTab(StuInfo.token, id).then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          setState(() {
            List data = value['data'];
            _infoList = data.map((e) => AssInfo.fromJson(e)).toList();
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

  Widget _assItem(AssInfo assInfo) {
    return Ink(
      color: Colors.white,
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AssInfoHome(assInfo: assInfo)));
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 15, 15),
              child: ClipOval(
                child: CachedNetworkImage(
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                    imageUrl: addPrefixToUrl(assInfo.icon),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Container(
                        width: 45,
                        height: 45,
                        color: Theme.of(context).primaryColor)),
              ),
            ),
            Text(
              assInfo.name,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const Spacer(),
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
}

class AssInfo {
  late int id;
  late String name;
  late String icon;
  late String introduce;
  late String qq;
  late String publicNum;

  AssInfo.fromJson(Map value) {
    id = value['id'];
    name = value['name'];
    icon = value['icon'];
    introduce = value['introduce'];
    qq = value['qq'];
    publicNum = value['publicNum'];
  }
}
