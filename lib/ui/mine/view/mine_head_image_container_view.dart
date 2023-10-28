import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/data/stu_info.dart';
import 'package:flutter/material.dart';

import '../../../common/cachedimage/view/cached_image.dart';

/// 我的页面头像区域View
///
/// @author zzp
/// @since 2023/10/22
/// @version v1.8.8
class MineHeadImageContainerView extends StatelessWidget {
  const MineHeadImageContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: _HeaderImageClipper(length: 20),
          child: Container(
            height: 150,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3),
                borderRadius: BorderRadius.circular(40),
              ),
              child: ClipOval(
                child: CachedImage(
                  url: StuInfo.avatar,
                  size: 64,
                  fit: BoxFit.cover,
                  isShowDetail: true,
                ),
              ),
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
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              margin: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              padding: const EdgeInsets.fromLTRB(5, 12, 5, 10),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    _underHeadImageCardContent(
                        iconData: Icons.school_outlined,
                        iconColor: Colors.blueGrey,
                        title: StringAssets.college,
                        content: StuInfo.college),
                    _underHeadImageCardContent(
                        iconData: Icons.local_library_outlined,
                        iconColor: Colors.teal,
                        title: StringAssets.major,
                        content: StuInfo.major),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  /// 头像下卡片内容区域
  ///
  /// [iconData] 图标
  /// [iconColor] 图标颜色
  /// [title] 标题
  /// [content] 内容
  Widget _underHeadImageCardContent({
    required IconData iconData,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 22,
                color: iconColor,
              ),
              const SizedBox(width: 3),
              Text(
                title,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            content,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

/// 头像容器裁剪类
///
/// @author zzp
/// @since 2023/10/22
/// @version v1.8.8
class _HeaderImageClipper extends CustomClipper<Path> {
  _HeaderImageClipper({required this.length});

  /// 三角形短边长
  final double length;

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - length);
    path.lineTo(length * 2, size.height);
    path.lineTo(size.width - length * 2, size.height);
    path.lineTo(size.width, size.height - length);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
