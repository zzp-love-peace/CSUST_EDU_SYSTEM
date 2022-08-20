import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/widgets/forum_item.dart';
import 'package:csust_edu_system/widgets/none_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../network/network.dart';
import '../utils/my_util.dart';
import '../widgets/custom_toast.dart';

class MyCollectHome extends StatefulWidget {
  const MyCollectHome({Key? key}) : super(key: key);

  @override
  State<MyCollectHome> createState() => _MyCollectHomeState();
}

class _MyCollectHomeState extends State<MyCollectHome> {

  List<Forum> _forumList = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _getMyCollects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text(
          "我的收藏",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: EasyRefresh(
          header: DeliveryHeader(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          onRefresh: () async{
            await Future.delayed(const Duration(milliseconds: 2000), ()
            {
              _getMyCollects();
            });
          },
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                margin: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  color: Colors.white
                ),
                child: Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 30,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('这里是你的收藏列表，遇到有用的帖子就点击星星收藏起来吧',))
                  ],
                ),
              ),
              if (_forumList.isNotEmpty)
                AnimatedList(
                    key: _listKey,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    initialItemCount: _forumList.length,
                    itemBuilder: (context, index, animation) {
                      return buildFadeWidget(
                          _getForumItem(_forumList[index]), animation);
                    })
              else const NoneLottie(hint: '空空如也...')
            ],
          )),
    );
  }

  Widget _getForumItem(forum) {
    return ForumItem(
      forum: forum,
      deleteCallback: _deleteCallback,
    );
  }

  _deleteCallback(Forum forum) {
    var index = _forumList.indexOf(forum);
    _forumList.remove(forum);
    _listKey.currentState?.removeItem(
        index,
            (context, animation) =>
            buildFadeWidget(_getForumItem(forum), animation),
        duration: const Duration(milliseconds: 500));
  }

  _getMyCollects() {
    HttpManager().getMyCollects(StuInfo.token).then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          setState(() {
            List data = value['data'];
            _forumList = data.map((e) => Forum.fromJson(e)).toList();
          });
        } else {
          SmartDialog.compatible.showToast('', widget: CustomToast(value['msg']));
        }
      } else {
        SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了'));
      }
    }, onError: (_){
      SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了'));
    });
  }
}
