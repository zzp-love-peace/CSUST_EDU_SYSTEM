import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../network/http_manager.dart';
import '../utils/my_util.dart';
import '../widgets/custom_toast.dart';
import '../widgets/forum_item.dart';
import '../widgets/none_lottie.dart';

class MyForumHome extends StatefulWidget {
  const MyForumHome({Key? key}) : super(key: key);

  @override
  State<MyForumHome> createState() => _MyForumHomeState();
}

class _MyForumHomeState extends State<MyForumHome> {
  List<Forum> _forumList = [];

  @override
  void initState() {
    super.initState();
    _getMyForums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "我的发帖",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: EasyRefresh(
            header: BezierHourGlassHeader(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            footer: BallPulseFooter(color: Theme.of(context).primaryColor),
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 3000), () {
                _getMyForums();
              });
            },
            child: _forumList.isNotEmpty
                ? ImplicitlyAnimatedList<Forum>(
                    items: _forumList,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    areItemsTheSame: (a, b) => a.id == b.id,
                    itemBuilder: (context, animation, item, index) {
                      return buildFadeWidgetVertical(_getForumItem(item), animation);
                    },
                    removeItemBuilder: (context, animation, oldItem) {
                      return buildFadeWidgetVertical(_getForumItem(oldItem), animation);
                    },
                  )
                // AnimatedList(
                //     key: _listKey,
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     initialItemCount: _forumList.length,
                //     itemBuilder: (context, index, animation) {
                //       return buildFadeWidget(
                //           _getForumItem(_forumList[index]), animation);
                //     })
                // ListView.builder(
                //   itemCount: _forumList.length,
                //   itemBuilder: _getForumItem,
                // )
                : const NoneLottie(
                    hint: '空空如也...',
                  )));
  }

  Widget _getForumItem(forum) {
    return ForumItem(
      forum: forum,
      deleteCallback: _deleteCallback,
    );
  }

  _deleteCallback(Forum forum) {
    // var index = _forumList.indexOf(forum);
    // print(index);
    setState(() {
      _forumList.remove(forum);
    });
    // _listKey.currentState?.removeItem(
    //     index,
    //     (context, animation) =>
    //         buildFadeWidget(_getForumItem(forum), animation),
    //     duration: const Duration(milliseconds: 500));
  }

  _getMyForums() {
    HttpManager().getMyForums(StuInfo.token).then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          setState(() {
            List data = value['data'];
            _forumList = data.map((e) => Forum.fromJson(e)).toList();
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
