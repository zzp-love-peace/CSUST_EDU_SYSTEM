import 'package:cached_network_image/cached_network_image.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:csust_edu_system/homes/detail_home.dart';
import 'package:csust_edu_system/network/http_manager.dart';
import 'package:csust_edu_system/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:like_button/like_button.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../route/fade_route.dart';
import '../utils/my_util.dart';
import 'custom_toast.dart';

class ForumItem extends StatefulWidget {
  final Forum forum;
  final Function(Forum) deleteCallback;

  const ForumItem({Key? key, required this.forum, required this.deleteCallback})
      : super(key: key);

  @override
  State<ForumItem> createState() => _ForumItemState();
}

class _ForumItemState extends State<ForumItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(12, 3, 12, 8),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Ink(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            onTap: () {
              _navigatorToDetailHome();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Hero(
                          tag: widget.forum.avatar + widget.forum.id.toString(),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              width: 42,
                              height: 42,
                              fit: BoxFit.cover,
                              imageUrl: '${widget.forum.avatar}/webp',
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  CachedNetworkImage(
                                      width: 42,
                                      height: 42,
                                      fit: BoxFit.cover,
                                      imageUrl: widget.forum.avatar,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                              width: 42,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(30)),
                                              ))),
                            ),
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: widget.forum.username +
                              widget.forum.id.toString(),
                          child: Text(
                            widget.forum.username,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Hero(
                            tag: widget.forum.createTime +
                                widget.forum.id.toString(),
                            child: Text(
                              getForumDateString(widget.forum.createTime),
                              style: const TextStyle(fontSize: 12),
                            ))
                      ],
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Hero(
                      tag: widget.forum.content + widget.forum.id.toString(),
                      child: Text(
                        widget.forum.content,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    )),
                if (widget.forum.images.isNotEmpty)
                  SizedBox(
                    height: ((MediaQuery.of(context).size.width - 24) / 3),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                      child: GridView.count(
                        reverse: true,
                        crossAxisSpacing: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        children: widget.forum.images
                            .map((url) => _imgView(url, widget.forum.images))
                            .toList(),
                      ),
                    ),
                  ),
                _controlRow(),
              ],
            ),
          ),
        ));
  }

  _navigatorToDetailHome() {
    Navigator.of(context).push(FadeRoute(page: DetailHome(
      forum: widget.forum,
      deleteCallback: widget.deleteCallback,
      stateCallback: (isLike, isCollect) {
        setState(() {
          if (widget.forum.isLike && !isLike) {
            widget.forum.likeNum--;
          } else if (!widget.forum.isLike && isLike) {
            widget.forum.likeNum++;
          }
          widget.forum.isLike = isLike;
          widget.forum.isEnshrine = isCollect;
        });
      },
    )));
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => DetailHome(
    //           forum: widget.forum,
    //           deleteCallback: widget.deleteCallback,
    //           stateCallback: (isLike, isCollect) {
    //             setState(() {
    //               if (widget.forum.isLike && !isLike) {
    //                 widget.forum.likeNum--;
    //               } else if (!widget.forum.isLike && isLike) {
    //                 widget.forum.likeNum++;
    //               }
    //               widget.forum.isLike = isLike;
    //               widget.forum.isEnshrine = isCollect;
    //             });
    //           },
    //         )));
  }

  Widget _controlRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Hero(
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
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            onTap: () {
              _navigatorToDetailHome();
            },
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.comment, size: 24, color: Colors.grey),
                    if (widget.forum.commentNum > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          widget.forum.commentNum.toString(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      )
                  ],
                )),
          ),
        ),
        Expanded(
            flex: 1,
            child: Hero(
              tag: 'like${widget.forum.id}',
              child: LikeButton(
                likeCount:
                    widget.forum.likeNum > 0 ? widget.forum.likeNum : null,
                onTap: onPraiseButtonTapped,
                size: 24,
                isLiked: widget.forum.isLike,
              ),
            )),
      ],
    );
  }

  Widget _imgView(String url, List images) {
    return Hero(
        tag: url,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(FadeRoute(
                page: ForumItemImages(
              images: images,
              url: url,
            )));
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (BuildContext context) {
            //   return ForumItemImages(
            //     images: images,
            //     url: url,
            //   );
            // }));
          },
          child: CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            imageUrl: '$url/thumb',
            // imageUrl: '$url/webp',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, newUrl, error) => CachedNetworkImage(
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                imageUrl: url,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Theme.of(context).primaryColor)),
          ),
        ));
  }

  Future<bool> onPraiseButtonTapped(bool isLiked) async {
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
    }
    return !isLiked;
  }

  Future<bool> onCollectButtonTapped(bool isLiked) async {
    try {
      var value =
          await HttpManager().collectForum(StuInfo.token, widget.forum.id);
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
    }
    return !isLiked;
  }
}

class ForumItemImages extends StatefulWidget {
  final List images;
  final String url;

  const ForumItemImages({Key? key, required this.images, required this.url})
      : super(key: key);

  @override
  State<ForumItemImages> createState() => _ForumItemImagesState();
}

class _ForumItemImagesState extends State<ForumItemImages> {
  late int imgIndex;

  @override
  void initState() {
    super.initState();
    imgIndex = widget.images.indexOf(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      onPageChanged: (index) {
        setState(() {
          imgIndex = index;
        });
      },
      pageController:
          PageController(initialPage: widget.images.indexOf(widget.url)),
      itemCount: widget.images.length,
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions.customChild(
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: CachedNetworkImage(
                    // imageUrl: '${widget.images[index]}/thumb',
                    imageUrl: '${widget.images[index]}/webp',
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return Center(
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, error, stackTrace) {
                      return const Center(
                          child: Icon(
                        Icons.question_mark,
                        color: Colors.white,
                      ));
                    },
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: Row(
                  children: [
                    const Text(
                      '图片',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      '${imgIndex + 1}/${widget.images.length}',
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.download,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        String url = widget.images[imgIndex];
                        var imgBytes = await HttpManager().imageToBytes(url);
                        var result = await ImageGallerySaver.saveImage(imgBytes,
                            quality: 100);
                        if (result['isSuccess'] == true) {
                          SmartDialog.compatible
                              .showToast('', widget: const CustomToast('下载成功'));
                        } else {
                          SmartDialog.compatible.showToast('',
                              widget: CustomToast(result['errorMessage']));
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          onTapUp: (context, details, controllerValue) {
            Navigator.pop(context);
          },
          heroAttributes: PhotoViewHeroAttributes(tag: widget.images[index]),
        );
      },
      loadingBuilder: (context, event) => Center(
        child: SizedBox(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
          ),
        ),
      ),
    );
  }
}

class Forum {
  late int id;
  late String avatar;
  late String username;
  late int userId;

  late String content;
  late int likeNum;

  // 是否已喜欢
  late bool isLike;

  // 是否已收藏
  late bool isEnshrine;

  late int commentNum;
  late String createTime;
  late List images;

  Forum.fromJson(Map value) {
    id = value['id'];
    avatar = value['userInfo']['avatar'];
    username = value['userInfo']['username'];
    userId = value['userInfo']['userId'];
    content = value['content'];
    createTime = value['createTime'];
    likeNum = value['likeNum'];
    commentNum = value['commentNum'];
    isLike = value['isLike'];
    isEnshrine = value['isEnshrine'];
    images = value['images'];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Forum &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          avatar == other.avatar &&
          username == other.username &&
          userId == other.userId &&
          content == other.content &&
          createTime == other.createTime &&
          likeNum == other.likeNum &&
          commentNum == other.commentNum &&
          isLike == other.isLike &&
          isEnshrine == other.isEnshrine &&
          images == other.images;

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + id.hashCode;
    result = 37 * result + avatar.hashCode;
    result = 37 * result + username.hashCode;
    result = 37 * result + userId.hashCode;
    result = 37 * result + content.hashCode;
    result = 37 * result + createTime.hashCode;
    result = 37 * result + likeNum.hashCode;
    result = 37 * result + commentNum.hashCode;
    result = 37 * result + isLike.hashCode;
    result = 37 * result + isEnshrine.hashCode;
    result = 37 * result + images.hashCode;
    return result;
  }
}
