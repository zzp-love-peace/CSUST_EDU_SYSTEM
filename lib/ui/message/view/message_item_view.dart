import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/message/jsonbean/message_bean.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/cachedimage/data/cached_image_type.dart';
import '../../../common/cachedimage/view/cached_image.dart';
import '../../../util/date_util.dart';
import '../viewmodel/message_viewmodel.dart';

/// 消息通知ItemView
///
/// @Author: Orcas_Liu
/// @version: 1.8.8
/// @Since: 2023.9.26
/// @Description: 组件拆分为单独文件，使项目结构更加清晰
class MessageItemView extends StatelessWidget {
  const MessageItemView({super.key, required this.msg, required this.isRead});

  /// 消息
  final MsgBean msg;

  /// 是否已读
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Ink(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          context.read<MessageViewModel>().pushDetail(msg, isRead);
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: ClipOval(
                child: CachedImage(
                  size: 45,
                  url: msg.userInfo.avatar,
                  type: CachedImageType.thumb,
                  fit: BoxFit.cover,
                  isShowDetail: true,
                ),
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
                    msg.userInfo.username,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 3, 15, 5),
                    child: msg.type == 0
                        ? Text(
                      '${StringAssets.comment}：${msg.content}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          )
                        : Text(
                      '${StringAssets.reply}：${msg.content}',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, bottom: 8),
                      child: Text(
                        DateUtil.getForumDateString(msg.createTime),
                        style:
                        const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (!isRead)
              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.circle,
                  size: 10,
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
