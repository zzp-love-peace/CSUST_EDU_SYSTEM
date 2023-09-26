import 'package:cached_network_image/cached_network_image.dart';
import 'package:csust_edu_system/ext/context_extension.dart';
import 'package:csust_edu_system/ui/message/jsonbean/message_bean.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../util/date_util.dart';
import '../viewmodel/message_viewmodel.dart';

/// 消息通知ItemView
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.26
/// @Description: 组件拆分为单独文件，使项目结构更加清晰
class MsgItemView extends StatelessWidget{
  const MsgItemView({super.key, required this.msg, required this.isRead});
  final Msg msg;
  final bool isRead;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Ink(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          context.readViewModel<MessageViewModel>().pushDetail(msg, isRead);
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
                  imageUrl: '${msg.avatar}/webp',
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => CachedNetworkImage(
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                      imageUrl: msg.avatar,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                          CircularProgressIndicator(
                              value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Container(
                          width: 45,
                          height: 45,
                          color: Theme.of(context).primaryColor)),),
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
  
}