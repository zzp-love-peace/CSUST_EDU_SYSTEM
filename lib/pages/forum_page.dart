import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:csust_edu_system/common/dialog/custom_toast.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/homes/write_forum_home.dart';
import 'package:csust_edu_system/network/http_manager.dart';
import 'package:csust_edu_system/widgets/forum_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../common/lottie/none_lottie.dart';
import '../util/my_util.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  List<Widget> _tabList = [];
  List<Widget> _tabPages = [];

  late List<String> _tabs;
  late List<int> _tabsId;

  static Map<int,Function> listCallbacks = {};

  @override
  void initState() {
    super.initState();
    _getAllTab();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _tabList.length,
        child: Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              // systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "圈子",
                style: TextStyle(
                  // color: Colors.white,
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
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButton: FloatingActionButton(
              foregroundColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WriteForumHome(
                          tabs: _tabs,
                          tabsId: _tabsId,
                      callback: (forum, id){
                        Function? function = listCallbacks[id];
                        Function? function2 = listCallbacks[0];
                        if (function != null) {
                          function(forum);
                        }
                        if (function2 != null) {
                          function2(forum);
                        }
                      },
                        )));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(Icons.edit),
            )));
  }

  _getAllTab() {
    HttpManager().getAllTab(StuInfo.token).then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          setState(() {
            List data = value['data'];
            _tabList = data
                .map((e) => Tab(
                      text: e['themeName'],
                    ))
                .toList();
            _tabPages = data.map((e) => _ForumList(tabId: e['id'])).toList();
            _tabList.insert(
                0,
                const Tab(
                  text: '全部',
                ));
            _tabPages.insert(0, const _ForumList(tabId: 0));
            _tabs = data.map((e) => e['themeName'].toString()).toList();
            _tabsId = data.map((e) => int.parse(e['id'].toString())).toList();
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

class _ForumList extends StatefulWidget {
  final int tabId;

  const _ForumList({Key? key, required this.tabId}) : super(key: key);

  @override
  State<_ForumList> createState() => _ForumListState();
}

class _ForumListState extends State<_ForumList>
    with AutomaticKeepAliveClientMixin {
  List<Forum> _forumList = [];

  int _page = 1;
  late int _totalPages;
  final _rows = 12;

// final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getFormListByTabId(widget.tabId);
    _ForumPageState.listCallbacks[widget.tabId] = _addCallback;
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        // header: DeliveryHeader(),
        header: BezierCircleHeader(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        footer: BallPulseFooter(color: Theme.of(context).primaryColor),
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1200), () {
            _page = 1;
            _getFormListByTabId(widget.tabId);
          });
        },
        onLoad: () async {
          await Future.delayed(const Duration(milliseconds: 1200), () {
            _page++;
            if (_page <= _totalPages) {
              _getFormListByTabId(widget.tabId);
            }
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
            //         key: _listKey,
            //         shrinkWrap: true,
            //         physics: const NeverScrollableScrollPhysics(),
            //         initialItemCount: _forumList.length,
            //         itemBuilder: (context, index, animation) {
            //           return buildFadeWidget(
            //               _getForumItem(_forumList[index]), animation);
            //         })
            : const NoneLottie(
                hint: '荒无人烟...',
              ));
  }

  Widget _getForumItem(forum) {
    return ForumItem(
      forum: forum,
      deleteCallback: _deleteCallback,
    );
  }

  _deleteCallback(Forum forum) {
    // var index = _forumList.indexOf(forum);
    setState(() {
      _forumList.remove(forum);
    });
    // _listKey.currentState?.removeItem(
    //     index,
    //     (context, animation) =>
    //         buildFadeWidget(_getForumItem(forum), animation),
    //     duration: const Duration(milliseconds: 500));
  }

  _addCallback(Forum forum) {
    setState(() {
      _forumList.insert(0, forum);
    });
  }

  _getFormListByTabId(int tabId) {
    HttpManager().getFormListByTabId(StuInfo.token, tabId, _page, _rows).then(
        (value) {
      if (value.isNotEmpty) {
        print(value);
        if (value['code'] == 200) {
          setState(() {
            int totalCount = value['data']['totalCount'];
            _totalPages = (totalCount / _rows).ceil();
            List data = value['data']['indexPosts'];
            if (_page == 1) {
              _forumList = data.map((e) => Forum.fromJson(e)).toList();
            } else {
              List<Forum> list = data.map((e) => Forum.fromJson(e)).toList();
              for (var item in list) {
                if (!_forumList.contains(item)) {
                  _forumList.add(item);
                }
              }
            }
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
