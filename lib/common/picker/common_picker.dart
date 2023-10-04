import 'package:csust_edu_system/util/typedef_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../../ass/string_assets.dart';

/// 通用选择器
///
/// @author zzp
/// @since 2023/10/4
/// @version v1.8.8
class CommonPicker<T> {
  /// 上一次选择的下标
  List<int> _selected = [];

  /// 选择器实例
  Picker? _picker;

  /// 初始化选择器
  ///
  /// [title] 标题
  /// [pickerData] 选择器数据
  /// [initIndex] 初始化下标
  /// [index] 展示后选择的下标
  /// [onConfirm] 确认回调
  Picker _initPicker(String title, List<T> pickerData, int initIndex,
      int? index, CommonPickerConfirm<T> onConfirm) {
    if (_picker == null) {
      _selected = [initIndex];
    }
    if (index != null) {
      _selected = [index];
    }
    return Picker(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.black),
      ),
      confirmText: StringAssets.ok,
      cancelText: StringAssets.cancel,
      selecteds: _selected,
      adapter: PickerDataAdapter<T>(pickerData: pickerData),
      changeToFirst: true,
      hideHeader: false,
      onConfirm: (Picker picker, List list) {
        int index = list[0];
        _selected = [index];
        var value = pickerData[index];
        onConfirm.call(value, index);
      },
    );
  }

  /// 展示选择器
  ///
  /// [context] context
  /// [title] 标题
  /// [pickerData] 选择器数据
  /// [onConfirm] 确认回调
  /// [initIndex] 初始化下标
  /// [index] 展示后选择的下标
  void showPicker(BuildContext context,
      {required String title,
      required List<T> pickerData,
      required CommonPickerConfirm<T> onConfirm,
      int initIndex = 0,
      int? index}) {
    _picker = _initPicker(title, pickerData, initIndex, index, onConfirm);
    _picker?.showModal(context);
  }
}
