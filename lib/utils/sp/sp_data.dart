import 'package:csust_edu_system/utils/sp/sp_util.dart';

/// SharedPreferences数据类
///
/// @author zzp
/// @since 2023/9/17
class SpData<T> {
  SpData({required this.key, required this.defaultValue});

  /// 键
  String key;
  /// 默认值
  T defaultValue;

  /// 获取
  T get() {
    T? value = SpUtil.get(key);
    if (value == null) {
      return defaultValue;
    } else {
      return value;
    }
  }

  /// 保存
  Future<bool> set(T value) async {
    return SpUtil.put(key, value);
  }
}