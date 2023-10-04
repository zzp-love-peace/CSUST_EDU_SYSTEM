import 'package:csust_edu_system/arch/baseview/seletor_view.dart';
import 'package:csust_edu_system/ui/message/jsonbean/message_bean.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

import '../../../ass/string_assets.dart';
import '../../../common/lottie/none_lottie.dart';
import '../viewmodel/message_viewmodel.dart';
import 'message_item_view.dart';

/// 消息列表View
///
/// @author zzp
/// @since 2023/10/3
/// @version v1.8.8
class MessageListView extends StatefulWidget {
  const MessageListView({super.key, required this.isReadList});

  /// 是否是已读消息列表
  final bool isReadList;

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SelectorView<MessageViewModel, List<MsgBean>>(
      onInit: (viewModel) {
        if (widget.isReadList) {
          viewModel.getReadMsg();
        } else {
          viewModel.getUnreadMsg();
        }
      },
      selector: (ctx, viewModel) => widget.isReadList
          ? viewModel.model.readMsgList
          : viewModel.model.unReadMsgList,
      builder: (ctx, msgList, _) {
        return EasyRefresh(
            header: MaterialHeader(),
            onRefresh: () async {
              var viewModel = context.read<MessageViewModel>();
              if (widget.isReadList) {
                viewModel.getReadMsg();
              } else {
                viewModel.getUnreadMsg();
              }
            },
            child: msgList.isNotEmpty
                ? ListView.builder(
              itemCount: msgList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return MessageItemView(
                          msg: msgList[index], isRead: widget.isReadList);
                    },
                  )
                : const NoneLottie(hint: StringAssets.messageEmpty));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
