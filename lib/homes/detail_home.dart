import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:csust_edu_system/common/dialog/select_dialog.dart';
import 'package:csust_edu_system/common/forumlist/view/forum_item_image_detail_view.dart';
import 'package:csust_edu_system/common/lottie/none_lottie.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/network/http_manager.dart';
import 'package:csust_edu_system/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:like_button/like_button.dart';

import '../common/dialog/custom_toast.dart';
import '../common/dialog/hint_dialog.dart';
import '../common/forumlist/jsonbean/forum_bean.dart';
import '../util/widget_util.dart';

class DetailHome extends StatefulWidget {
  final ForumBean forum;
  final Function(bool, bool) stateCallback;
  final Function? deleteCallback;

  const DetailHome(
      {Key? key,
      required this.forum,
      required this.stateCallback,
      this.deleteCallback})
      : super(key: key);

  @override
  State<DetailHome> createState() => _DetailHomeState();
}

class _DetailHomeState extends State<DetailHome> {
  late bool _isLike;
  late bool _isCollect;
  final _contentController = TextEditingController();

  List<_Comment> _commentList = [];

  @override
  void initState() {
    super.initState();
    _getFormInfo(widget.forum.id);
    _isLike = widget.forum.isLike;
    _isCollect = widget.forum.isEnshrine;
    print(widget.forum.likeNum);

  }

  @override
  void dispose() {
    super.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: _detailAppBar(),
          body: Column(
            children: [
              Expanded(
                child: EasyRefresh(
                  header: MaterialHeader(),
                  onRefresh: () async {
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      _getFormInfo(widget.forum.id);
                    });
                  },
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Hero(
                              tag: widget.forum.avatar +
                                  widget.forum.id.toString(),
                              child: _headImage()),
                          Hero(
                            tag: widget.forum.username +
                                widget.forum.id.toString(),
                            child: Text(
                              widget.forum.username,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 20, 24, 20),
                                child: Hero(
                                  tag: widget.forum.content +
                                      widget.forum.id.toString(),
                                  child: SelectableText(
                                    widget.forum.content,
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.black),
                                  ),
                                )),
                          ),
                          if (widget.forum.images.isNotEmpty)
                            SizedBox(
                              height:
                                  ((MediaQuery.of(context).size.width - 24) /
                                          3) +
                                      6,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 0, 12, 10),
                                child: GridView.count(
                                  reverse: true,
                                  crossAxisSpacing: 3,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: 3,
                                  children: widget.forum.images
                                      .map((url) =>
                                          _imgView(url, widget.forum.images))
                                      .toList(),
                                ),
                              ),
                            ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: const EdgeInsets.only(right: 24),
                                child: Hero(
                                  tag: widget.forum.createTime +
                                      widget.forum.id.toString(),
                                  child: Text(
                                    getForumDateString(widget.forum.createTime),
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          _likeAndCollectRow(),
                          // if (_commentList.isNotEmpty)
                          ImplicitlyAnimatedList<_Comment>(
                            items: _commentList,
                            shrinkWrap: true,
                            updateDuration: const Duration(milliseconds: 300),
                            insertDuration: const Duration(milliseconds: 300),
                            physics: const NeverScrollableScrollPhysics(),
                            areItemsTheSame: (a, b) => a.id == b.id,
                            itemBuilder: (context, animation, item, index) {
                              return WidgetUtil.buildFadeWidgetVertical(
                                  _CommentItem(
                                      comment: item,
                                      deleteCallback: _deleteCallback),
                                  animation);
                            },
                            removeItemBuilder: (context, animation, oldItem) {
                              return WidgetUtil.buildFadeWidgetVertical(
                                  _CommentItem(
                                      comment: oldItem,
                                      deleteCallback: _deleteCallback),
                                  animation);
                            },
                          ),
                          if (_commentList.isEmpty)
                            const NoneLottie(hint: '荒无人烟...')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _bottomCommentView(),
            ],
          ),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() {
    widget.stateCallback(_isLike, _isCollect);
    return Future.value(true);
  }

  AppBar _detailAppBar() {
    return AppBar(
      elevation: 0,
      foregroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        "详情",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        widget.forum.userId == StuInfo.id
            ? IconButton(
                onPressed: () {
                  SmartDialog.compatible.show(
                      widget: SelectDialog(
                          title: '提示',
                          subTitle: '您确定要删除该帖子吗？',
                          okCallback: () {
                            _deleteForum(widget.forum.id);
                          }),
                      clickBgDismissTemp: false);
                },
                icon: const Icon(Icons.delete))
            : IconButton(
                onPressed: () {
                  SmartDialog.compatible.show(
                      widget: SelectDialog(
                        title: '提示',
                        subTitle: '您确定要举报该帖子吗？',
                        okCallback: () {
                          _reportComment(widget.forum.id);
                        },
                      ),
                      clickBgDismissTemp: false);
                },
                icon: const Icon(Icons.warning))
      ],
    );
  }

  Widget _headImage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 8),
      child: Container(
        width: 64,
        height: 64,
        child: ClipOval(
            child: CachedNetworkImage(
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                imageUrl: '${widget.forum.avatar}/webp',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => CachedNetworkImage(
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    imageUrl: widget.forum.avatar,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(40)),
                        ))))),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }

  Widget _imgView(String url, List<String> images) {
    return Hero(
        tag: url,
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).push(FadeRoute(
            //     page: ForumItemImages(images: images, url: url)));
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return ForumItemImageDetailView(
                images: images,
                initUrl: url,
              );
            }));
          },
          child: CachedNetworkImage(
              // width: double.infinity,
              // height: double.infinity,
              fit: BoxFit.cover,
              imageUrl: '$url/thumb',
              // imageUrl: '$url/webp',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Theme.of(context).primaryColor)),
        ));
  }

  Widget _bottomCommentView() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      // height: 50,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if(widget.forum.isAdvertise==false){
                  _showCommentBottomSheet(
                      context, _contentController, _postComment);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 10, 5, 10),
                      child: Icon(
                        Icons.edit,
                        color: Colors.black45,
                      ),
                    ),
                    Text(
                      '写评论',
                      style: TextStyle(color: Colors.black45),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Hero(
              tag: 'collect${widget.forum.id}',
              child: LikeButton(
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.star,
                    color: isLiked ? Colors.amberAccent : Colors.grey,
                    size: 24,
                  );
                },
                isLiked: widget.forum.isEnshrine,
                likeCount: null,
                onTap: onCollectButtonTapped,
              )),
          const SizedBox(
            width: 15,
          ),
          Hero(
            tag: 'like${widget.forum.id}',
            child: LikeButton(
              likeCount: null,
              onTap: onPraiseButtonTapped,
              size: 24,
              isLiked: widget.forum.isLike,
            ),
          )
        ],
      ),
    );
  }

  Widget _likeAndCollectRow() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.message_outlined,
                  color: Colors.black54,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text('评论'),
                const SizedBox(
                  width: 5,
                ),
                Text(widget.forum.commentNum.toString())
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.thumb_up_outlined,
                  color: Colors.black54,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text('点赞'),
                const SizedBox(
                  width: 5,
                ),
                Text(widget.forum.likeNum.toString())
              ],
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
  _likeAdvertise(){
    HttpManager().likeAdvertise(StuInfo.token, widget.forum.id).then((value){
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          print("likeAdvertise");
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
    // widget.forum.likeNum++;
  }

  _getFormInfo(int id) {
    HttpManager().getForumInfo(StuInfo.token, id).then((value) {
      if (value.isNotEmpty) {
        print(value);
        if (value['code'] == 200) {
          setState(() {
            widget.forum.isLike = value['data']['indexPost']['isLike'];
            widget.forum.isEnshrine = value['data']['indexPost']['isEnshrine'];
            widget.forum.commentNum = value['data']['indexPost']['commentNum'];
            widget.forum.likeNum = value['data']['indexPost']['likeNum'];
            _isLike = widget.forum.isLike;
            _isCollect = widget.forum.isEnshrine;
            List comments = value['data']['commentInfo'];
            _commentList = comments.map((e) => _Comment.fromJson(e)).toList();
          });
        } else {
          if(widget.forum.isAdvertise==false){
            SmartDialog.compatible
                .showToast('', widget: CustomToast(value['msg']));
          }else{
            SmartDialog.compatible
                .showToast('', widget: const CustomToast("( =•ω•= )m"));
          }



        }
      } else {
        SmartDialog.compatible
            .showToast('', widget: const CustomToast('出现异常了'));
      }
    }, onError: (_) {
      SmartDialog.compatible.showToast('', widget: const CustomToast('出现异常了'));
    });
  }

  _deleteForum(int postId) {
    HttpManager().deleteForum(StuInfo.token, postId).then((value) {
      if (value.isNotEmpty) {
        // print(value);
        if (value['code'] == 200) {
          SmartDialog.compatible
              .showToast('', widget: const CustomToast('删除成功'));
          Navigator.pop(context);
          if (widget.deleteCallback != null) {
            widget.deleteCallback!(widget.forum);
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

  Future<bool> onPraiseButtonTapped(bool isLiked) async {
    if(widget.forum.isAdvertise==false){
      try {
        var value = await HttpManager().likeForum(StuInfo.token, widget.forum.id);
        if (value.isNotEmpty) {
          if (value['code'] == 200) {
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
      }}
    else{
      _likeAdvertise();

    }
    _isLike = !isLiked;
    return !isLiked;
  }

  Future<bool> onCollectButtonTapped(bool isLiked) async {
    try {
      var value =
          await HttpManager().collectForum(StuInfo.token, widget.forum.id);
      if (value.isNotEmpty) {
         print(value);
        if (value['code'] == 200) {
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
    _isCollect = !isLiked;
    return !isLiked;
  }

  _postComment(String content) {
    SmartDialog.showLoading(msg: '上传中...');
    HttpManager().postComment(StuInfo.token, widget.forum.id, content).then(
        (value) {
      if (value.isNotEmpty) {
        // print('comment$value');
        if (value['code'] == 200) {
          SmartDialog.dismiss();
          Navigator.pop(context);
          _contentController.clear();
          setState(() {
            _commentList.insert(0, _Comment.fromJson(value['data']));
            widget.forum.commentNum++;
          });
        } else if (value['code'] == 701) {
          //被禁言了
          SmartDialog.compatible.show(
              widget: HintDialog(title: '提示', subTitle: value['msg']),
              clickBgDismissTemp: false);
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

  _reportComment(int postId) {
    SmartDialog.showLoading(msg: '上传中...');
    HttpManager().reportComment(StuInfo.token, postId).then((value) {
      SmartDialog.dismiss();
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          SmartDialog.compatible.show(
              widget:
                  const HintDialog(title: '提示', subTitle: '您的举报已收到，我们将尽快核实并受理'),
              clickBgDismissTemp: false);
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

  _deleteCallback(_Comment comment) {
    setState(() {
      widget.forum.commentNum--;
      _commentList.remove(comment);
    });
  }
}

class _CommentItem extends StatefulWidget {
  final _Comment comment;
  final Function(_Comment) deleteCallback;

  const _CommentItem(
      {Key? key, required this.comment, required this.deleteCallback})
      : super(key: key);

  @override
  State<_CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<_CommentItem> {
  final _contentController = TextEditingController();
  bool _isExpanded = false;
  final List<_Reply> _emptyList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Ink(
        // color: Colors.white,
        child: InkWell(
          onLongPress: () {
            SmartDialog.compatible
                .show(widget: _controlDialog(), isLoadingTemp: false);
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        imageUrl: '${widget.comment.avatar}/webp',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            CachedNetworkImage(
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                imageUrl: widget.comment.avatar,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) => Container(
                                    width: 40,
                                    height: 40,
                                    color: Theme.of(context).primaryColor)),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.comment.username,
                      style: TextStyle(
                          fontSize: 14, color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 8, 0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          widget.comment.content,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        )),
                      ],
                    )),
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Text(
                      getForumDateString(widget.comment.createTime),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    TextButton(
                      onPressed: () {
                        _showCommentBottomSheet(
                            context, _contentController, _postReply,
                            hint: '回复给 ${widget.comment.username}:');
                      },
                      child: Text(
                        '回复',
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
                ImplicitlyAnimatedList<_Reply>(
                  items: _isExpanded ? widget.comment.replyList : _emptyList,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  areItemsTheSame: (a, b) => a.id == b.id,
                  itemBuilder: (context, animation, item, index) {
                    return WidgetUtil.buildFadeWidgetVertical(
                        _replyItem(item), animation);
                  },
                  removeItemBuilder: (context, animation, oldItem) {
                    return WidgetUtil.buildFadeWidgetVertical(
                        _replyItem(oldItem), animation);
                  },
                ),
                if (widget.comment.replyList.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 2),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            _isExpanded ? '收起回复' : '展开回复',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                          ),
                          _isExpanded
                              ? const Icon(Icons.arrow_drop_up)
                              : const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _controlDialog({_Reply? reply}) {
    var isComment = reply == null;
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: double.infinity,
          child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          SmartDialog.dismiss();
                          Clipboard.setData(ClipboardData(
                              text: isComment
                                  ? widget.comment.content
                                  : reply.content));
                          SmartDialog.compatible
                              .showToast('', widget: const CustomToast('复制成功'));
                        },
                        child: const Text(
                          '复制',
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                  if (isComment && widget.comment.userId == StuInfo.id ||
                      !isComment && reply.userId == StuInfo.id)
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            SmartDialog.dismiss();
                            SmartDialog.compatible.show(
                                widget: SelectDialog(
                                  title: '提示',
                                  subTitle: '您确定要删除该评论吗？',
                                  okCallback: () {
                                    if (isComment) {
                                      _deleteComment(widget.comment.id);
                                    } else {
                                      _deleteReply(reply);
                                    }
                                  },
                                ),
                                clickBgDismissTemp: false);
                          },
                          child: const Text(
                            '删除',
                            style: TextStyle(fontSize: 16),
                          )),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            SmartDialog.dismiss();
                            SmartDialog.compatible.show(
                                widget: SelectDialog(
                                  title: '提示',
                                  subTitle: '您确定要举报该评论吗？',
                                  okCallback: () {
                                    SmartDialog.showLoading(msg: '上传中...');
                                    Future.delayed(
                                        const Duration(milliseconds: 1200), () {
                                      SmartDialog.dismiss();
                                      SmartDialog.compatible.show(
                                          widget: const HintDialog(
                                              title: '提示',
                                              subTitle: '您的举报已收到，我们将尽快核实并受理'),
                                          clickBgDismissTemp: false);
                                    });
                                  },
                                ),
                                clickBgDismissTemp: false);
                          },
                          child: const Text(
                            '举报',
                            style: TextStyle(fontSize: 16),
                          )),
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          SmartDialog.dismiss();
                          _showCommentBottomSheet(
                              context, _contentController, _postReply,
                              hint:
                                  '回复给 ${isComment ? widget.comment.username : reply.username}:',
                              replyId: reply?.userId);
                        },
                        child: const Text(
                          '回复',
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                ],
              ))),
    );
  }

  Widget _replyItem(_Reply reply) {
    return Padding(
        padding: const EdgeInsets.only(left: 50, bottom: 3),
        child: Ink(
          child: InkWell(
              onLongPress: () {
                SmartDialog.compatible.show(
                    widget: _controlDialog(reply: reply), isLoadingTemp: false);
              },
              onTap: () {
                _showCommentBottomSheet(context, _contentController, _postReply,
                    hint: '回复给 ${reply.username}:', replyId: reply.userId);
              },
              child: Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                      imageUrl: '${reply.avatar}/webp',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => CachedNetworkImage(
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                          imageUrl: reply.avatar,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Container(
                              width: 30,
                              height: 30,
                              color: Theme.of(context).primaryColor)),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Expanded(
                      child: RichText(
                    text: TextSpan(
                        text: reply.replyName == null
                            ? '${reply.username}：'
                            : reply.username,
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor),
                        children: [
                          if (reply.replyName != null)
                            const TextSpan(
                              text: ' 回复 ',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                            ),
                          if (reply.replyName != null)
                            TextSpan(
                              text: '${reply.replyName}：',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor),
                            ),
                          TextSpan(
                            text: reply.content,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ]),
                  ))
                ],
              )),
          color: Colors.white,
        ));
  }

  _postReply(String content, {int? replyId}) {
    HttpManager()
        .postReply(StuInfo.token, widget.comment.id, replyId ?? 0, content)
        .then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          setState(() {
            widget.comment.replyList.add(_Reply.fromJson(value['data']));
            if (_isExpanded == false) {
              _isExpanded = true;
            }
          });
          SmartDialog.dismiss();
          Navigator.pop(context);
          _contentController.clear();
        } else if (value['code'] == 701) {
          SmartDialog.compatible.show(
              widget: HintDialog(title: '提示', subTitle: value['msg']),
              clickBgDismissTemp: false);
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

  _deleteComment(int commentId) {
    HttpManager().deleteComment(StuInfo.token, commentId).then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          widget.deleteCallback(widget.comment);
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

  _deleteReply(_Reply reply) {
    HttpManager().deleteReply(StuInfo.token, reply.id).then((value) {
      if (value.isNotEmpty) {
        if (value['code'] == 200) {
          setState(() {
            widget.comment.replyList.remove(reply);
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

_showCommentBottomSheet(context, contentController, function,
    {hint = '说点啥...', int? replyId}) {
  // print(replyId);
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
      ),
      builder: (context) {
        return SingleChildScrollView(
            child: Container(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                padding: EdgeInsets.fromLTRB(
                    10, 10, 10, MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon(Icons.remove, color: Colors.grey,),
                    const Text(
                      '评论',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: TextField(
                        controller: contentController,
                        maxLength: 100,
                        minLines: 5,
                        maxLines: 5,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: hint),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            child: const Text(
                              '取消',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: TextButton(
                            child: const Text(
                              '发布',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              if (contentController.text.isNotEmpty) {
                                if (replyId == null) {
                                  function(contentController.text);
                                } else {
                                  function(contentController.text,
                                      replyId: replyId);
                                }
                              } else {
                                SmartDialog.compatible.showToast('',
                                    widget: const CustomToast('不能为空哦'));
                              }
                            },
                          ),
                          flex: 1,
                        ),
                      ],
                    )
                  ],
                )));
      });
}

class _Comment {
  late int id;
  late String avatar;
  late String username;
  late int userId;

  late String content;
  late String createTime;
  late List<_Reply> replyList;

  _Comment(this.id, this.avatar, this.username, this.userId, this.content,
      this.createTime, this.replyList);

  _Comment.fromJson(Map value) {
    id = value['id'];
    avatar = value['userInfo']['avatar'];
    username = value['userInfo']['username'];
    userId = value['userInfo']['userId'];
    content = value['content'];
    createTime = value['createTime'];
    List replyInfo = value['replyInfos'];
    replyList = replyInfo.map((e) => _Reply.fromJson(e)).toList();
  }

  @override
  String toString() {
    return "{replyList->$replyList}";
  }
}

class _Reply {
  late int id;
  late String avatar;
  late String username;
  late int userId;
  late String content;
  late String createTime;
  late int commentId;
  late String? replyName;

  _Reply.fromJson(Map value) {
    id = value['id'];
    avatar = value['userInfo']['avatar'];
    username = value['userInfo']['username'];
    userId = value['userInfo']['userId'];
    content = value['content'];
    createTime = value['createTime'];
    commentId = value['commentId'];
    replyName = value['replyName'];
  }
}
