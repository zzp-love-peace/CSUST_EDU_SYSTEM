import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/network/network.dart';
import 'package:csust_edu_system/utils/date_util.dart';
import 'package:csust_edu_system/widgets/forum_item.dart';
import 'package:csust_edu_system/widgets/none_lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import '../provider/theme_color_provider.dart';
import '../provider/unread_msg_provider.dart';
import '../utils/my_util.dart';
import '../widgets/custom_toast.dart';
import 'detail_home.dart';

class MessageHome extends StatefulWidget {
  const MessageHome({Key? key}) : super(key: key);

  @override
  State<MessageHome> createState() => _MessageHomeState();
}

class _MessageHomeState extends State<MessageHome> {
  final List<Widget> _tabList = [
    const Tab(
      text: '未读',
    ),
    const Tab(
      text: '已读',
    )
  ];

  final List<_Msg> _unreadMsgList = [];
  List<_Msg> _readMsgList = [];

  // final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _getUnreadMsg();
    _getReadMsg();
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
            "我的消息",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            labelStyle: const TextStyle(fontSize: 16),
            tabs: _tabList,
          ),
          actions: [
            TextButton(
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.grey.withOpacity(0.2))),
                onPressed: () {
                  _setAllMsgRead();
                },
                child: const Text(
                  '全部已读',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
        body: TabBarView(children: [
          EasyRefresh(
              header: MaterialHeader(),
              onRefresh: () async {
                _getUnreadMsg();
              },
              child: _unreadMsgList.isNotEmpty ?
              ImplicitlyAnimatedList<_Msg>(
                items: _unreadMsgList,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                areItemsTheSame: (a, b) => a.id == b.id,
                itemBuilder: (context, animation, item, index) {
                  return buildFadeWidget(_msgItem(item, false), animation);
                },
                removeItemBuilder: (context, animation, oldItem) {
                  return buildFadeWidget(_msgItem(oldItem, true), animation);
                },
              ) : const NoneLottie(hint: '空空如也...')
              // AnimatedList(
              //     key: _listKey,
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     initialItemCount: _unreadMsgList.length,
              //     itemBuilder: (context, index, animation) {
              //       return buildFadeWidget(
              //           _msgItem(_unreadMsgList[index], false), animation);
              //     }),
              ),
          EasyRefresh(
            header: MaterialHeader(),
            onRefresh: () async {
              _getReadMsg();
            },
            child: _readMsgList.isNotEmpty ?
            ListView.builder(
                itemCount: _readMsgList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _msgItem(_readMsgList[index], true);
                }) : const NoneLottie(hint: '空空如也...')
          )
        ]),
      ),
    );
  }

  Widget _msgItem(_Msg msg, bool isRead) {
    return Ink(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          _pushDetail(msg, isRead);
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: ClipOval(
                child: CachedNetworkImage(
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                    imageUrl: addPrefixToUrl(msg.avatar),
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
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text(
                  msg.username,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 3, 15, 5),
                  child: msg.type == 0
                      ? Text(
                          '评论：${msg.content}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                        )
                      : Text(
                          '回复：${msg.content}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                        ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, bottom: 8),
                      child: Text(
                        getForumDateString(msg.createTime),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ))
              ],
            )),
            if (!isRead)
              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.circle,
                  size: 10,
                  color: Colors.red,
                ),
              )
          ],
        ),
      ),
    );
  }

  _getUnreadMsg() async {
    try {
      var value = await HttpManager().getUnreadMsg(StuInfo.token);
      if (value.isNotEmpty) {
        print('_getUnreadMsg:$value');
        if (value['code'] == 200) {
          List data = value['data'];
          for (var msgData in data) {
            var msg = _Msg.fromJson(msgData);
            if (!_unreadMsgList.contains(msg)) {
              // int index = _unreadMsgList.length;
              setState(() {
                _unreadMsgList.add(msg);
              });
              // _listKey.currentState?.insertItem(index);
            }
          }
          // setState(() {});
        } else {
          SmartDialog.compatible
              .showToast('', widget: CustomToast(value['msg']));
        }
      } else {
        SmartDialog.compatible
            .showToast('', widget: const CustomToast('出现异常了'));
      }
    } on Exception {
      SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了'));
    }
  }

  _getReadMsg() async {
    try {
      var value = await HttpManager().getReadMsg(StuInfo.token);
      if (value.isNotEmpty) {
        print('_getReadMsg:$value');
        if (value['code'] == 200) {
          setState(() {
            List data = value['data'];
            _readMsgList = data.map((e) => _Msg.fromJson(e)).toList();
          });
        } else {
          SmartDialog.compatible
              .showToast('', widget: CustomToast(value['msg']));
        }
      } else {
        SmartDialog.compatible
            .showToast('', widget: const CustomToast('出现异常了'));
      }
    } on Exception {
      SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了'));
    }
  }

  _pushDetail(_Msg msg, bool isRead) {
    HttpManager().getForumInfo(StuInfo.token, msg.postId).then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          var forum = Forum.fromJson(value['data']['indexPost']);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailHome(
                    forum: forum,
                    stateCallback: (isLike, isCollect) {
                      if (!isRead) {
                        _setMsgRead(msg);
                      }
                    },
                  )));
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

  _setMsgRead(_Msg msg) {
    HttpManager().setMsgRead(StuInfo.token, msg.id, msg.type).then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          // var index = _unreadMsgList.indexOf(msg);
          // _listKey.currentState?.removeItem(
          //     index,
          //     (context, animation) =>
          //         buildFadeWidget(_msgItem(msg, true), animation),
          //     duration: const Duration(milliseconds: 500));
          setState(() {
            _unreadMsgList.remove(msg);
            _readMsgList.add(msg);
          });
          if (_unreadMsgList.isEmpty) {
            Provider.of<UnreadMsgProvider>(context, listen: false)
                .setHasNewMsg(_unreadMsgList.isNotEmpty);
          }
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

  _setAllMsgRead() {
    HttpManager().setAllMsgRead(StuInfo.token).then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          setState(() {
            _readMsgList.addAll(_unreadMsgList);
            _unreadMsgList.clear();
          });
          Provider.of<UnreadMsgProvider>(context, listen: false)
              .setHasNewMsg(_unreadMsgList.isNotEmpty);
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

class _Msg {
  late int id;
  late String avatar;
  late String username;
  late int userId;
  late String content;
  late String createTime;
  late int postId;
  late int type; // 0是评论 1是回复

  _Msg.fromJson(Map value) {
    id = value['id'];
    avatar = value['userInfo']['avatar'];
    username = value['userInfo']['username'];
    userId = value['userInfo']['userId'];
    content = value['content'];
    createTime = value['createTime'];
    postId = value['postId'];
    type = value['type'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Msg &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          avatar == other.avatar &&
          username == other.username &&
          userId == other.userId &&
          content == other.content &&
          createTime == other.createTime &&
          postId == other.postId &&
          type == other.type;

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + avatar.hashCode;
    result = 37 * result + username.hashCode;
    result = 37 * result + userId.hashCode;
    result = 37 * result + content.hashCode;
    result = 37 * result + createTime.hashCode;
    result = 37 * result + postId.hashCode;
    result = 37 * result + type.hashCode;
    return result;
  }
}
