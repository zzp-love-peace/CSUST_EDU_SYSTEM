import 'package:cached_network_image/cached_network_image.dart';
import 'package:csust_edu_system/common/dialog/custom_toast.dart';
import 'package:csust_edu_system/common/dialog/select_dialog.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/homes/info_home.dart';
import 'package:csust_edu_system/homes/my_collect_home.dart';
import 'package:csust_edu_system/homes/my_forum_home.dart';
import 'package:csust_edu_system/ui/login/page/login_page.dart';
import 'package:csust_edu_system/ui/setting/page/setting_page.dart';
import 'package:csust_edu_system/ui/message/page/message_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

import '../provider/unread_msg_provider.dart';

class MinePage extends StatelessWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _minePageAppBar(context),
      body: ListView(
        children: [
          const _MineHeader(),
          Card(
            margin: const EdgeInsets.fromLTRB(12, 30, 12, 0),
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.person_outline,
                      // color: Theme.of(context).primaryColor,
                      color: Colors.redAccent,
                    ),
                    title: const Text('个人资料'),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const InfoHome()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    leading: const Icon(Icons.forum_outlined,
                        // color: Theme.of(context).primaryColor
                        color: Colors.orange),
                    title: const Text('我的发帖'),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MyForumHome()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    leading: const Icon(Icons.star_outline,
                        // color: Theme.of(context).primaryColor
                        color: Colors.amber),
                    title: const Text('我的收藏'),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MyCollectHome()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    leading: const Icon(Icons.message_outlined,
                        // color: Theme.of(context).primaryColor
                        color: Colors.green),
                    title: const Text('我的消息'),
                    trailing: Consumer<UnreadMsgProvider>(builder: (context, appInfo, _)=>Stack(
                      alignment: Alignment.centerLeft,
                      children:  [
                        const Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Icon(
                            Icons.navigate_next,
                            color: Colors.black,
                          ),
                        ),
                        if (appInfo.hasNewMsg) const Padding(padding: EdgeInsets.only(right: 30), child: Icon(Icons.circle, color: Colors.red, size: 9,),)
                      ],
                    ),),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MessagePage()));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    leading: const Icon(Icons.group_add_outlined,
                        // color: Theme.of(context).primaryColor
                        color: Colors.cyan),
                    title: const Text('加入app交流群'),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Clipboard.setData(const ClipboardData(
                          text: '493018572'));
                      SmartDialog.compatible
                          .showToast('', widget: const CustomToast('复制qq群号成功'));
                      SmartDialog.compatible.show(widget: const AlertDialog(
                      title: Text("信息提示",style: TextStyle(
                      fontSize: 16, color: Colors.black),),
                      content: Text("教务app交流1群：955731766"+'\n'+ "教务app交流2群：493018572",style: TextStyle(fontSize: 15),),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))
                      ),),);

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ListTile(
                    leading: const Icon(Icons.settings_outlined,
                        // color: Theme.of(context).primaryColor
                        color: Colors.blue),
                    title: const Text('设置'),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                    ),
                    onTap: () {
                      context.push(const SettingPage());
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }



  AppBar _minePageAppBar(context) {
    return AppBar(
      elevation: 0,
      // systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            SmartDialog.compatible.show(
                widget: SelectDialog(
                  title: '提示',
                  subTitle: '确定要退出登录吗？',
                  callback: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  },
                ),
                clickBgDismissTemp: false);
          },
          icon: const Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
        )
      ],
      centerTitle: true,

      title: const Text(
        "我的",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _MineHeader extends StatefulWidget {
  const _MineHeader({Key? key}) : super(key: key);

  @override
  State<_MineHeader> createState() => _MineHeaderState();
}

class _MineHeaderState extends State<_MineHeader> {
  var _liquidValue = 0.0;
  var _isIncrease = true;
  var _isLoop = true;

  @override
  void initState() {
    _circulate();
    super.initState();
  }

  @override
  void dispose() {
    _isLoop = false;
    super.dispose();
  }

  _circulate() async {
    while (_isLoop) {
      await Future.delayed(const Duration(milliseconds: 300));
      var value = _liquidValue;
      if (_isIncrease) {
        value += 0.005;
        if (value > 1) {
          value -= 0.005;
          _isIncrease = false;
        }
      } else {
        value -= 0.005;
        if (value < 0.0) {
          value += 0.005;
          _isIncrease = true;
        }
      }
      if (mounted) {
        setState(() {
          _liquidValue = value;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
          child: LiquidLinearProgressIndicator(
              value: _liquidValue,
              borderColor: Colors.white10,
              borderWidth: 0,
              // backgroundColor: Colors.white10,
              valueColor:
              AlwaysStoppedAnimation(Theme
                  .of(context)
                  .primaryColor),
              direction: Axis.vertical,
              center: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                   Container(
                    width: 64,
                    height: 64,
                    //alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(40),
                    ),
                    child:  ClipOval(
                        child:
                        CachedNetworkImage(
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                            imageUrl: '${StuInfo.avatar}/webp',
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>  CachedNetworkImage(
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                                imageUrl: StuInfo.avatar,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                errorWidget: (context, url, error) => Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(40)),
                                    ))))),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    StuInfo.username,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ))),
    );
  }
}

