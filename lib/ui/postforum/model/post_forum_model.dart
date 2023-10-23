import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/picker/common_picker.dart';

/// 发帖Model
///
/// @author zzp
/// @since 2023/10/23
/// @version v1.8.8
class PostForumModel {
  PostForumModel(
      {required this.tabList,
      required this.tabIdList,
      this.tab = StringAssets.emptyStr,
      this.isAnonymous = false});

  /// 标签列表
  final List<String> tabList;

  /// 标签id列表
  final List<int> tabIdList;

  /// 标签
  String tab;

  /// 图片路径list
  List<String> imgPaths = [''];

  /// 是否匿名
  bool isAnonymous;

  /// 内容输入控制器
  final contentController = TextEditingController();

  /// 标签选择器
  final tabPicker = CommonPicker<String>();
}
