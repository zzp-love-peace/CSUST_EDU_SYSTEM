import 'package:csust_edu_system/utils/extension_uitl.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences工具类
///
/// @author zzp
/// @since 2023/9/17
/// @version v1.8.8
class SpUtil {

  /// SharedPreferences对象
  static SharedPreferences? _prefs;
  
  /// 初始化
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  /// 保存
  ///
  /// [key] 键
  /// [value] 值
  static Future<bool> put(String key, value) async {
    if (_prefs == null) {
      throw SpUtilNotInitException();
    }
    bool res = false;
    if (value is String && value.isNotBlank()) {
      res = await _prefs!.setString(key, value);
    } else if (value is int) {
      res = await _prefs!.setInt(key, value);
    } else if (value is double) {
      res = await _prefs!.setDouble(key, value);
    } else if (value is bool) {
      res = await _prefs!.setBool(key, value);
    } else if (value is List) {
      res = await _prefs!.setStringList(key, value.cast<String>());
    }
    return res;
  }

  /// 获取
  ///
  /// [key] 键
  static T get<T>(String key, T defaultValue) {
    if (_prefs == null) {
      throw SpUtilNotInitException();
    }
    T? res;
    if (T == String) {
      res = _prefs!.getString(key) as T?;
    } else if (T == int) {
      res = _prefs!.getInt(key) as T?;
    } else if (T == double) {
      res = _prefs!.getDouble(key) as T?;
    } else if (T == bool) {
      res = _prefs!.getBool(key) as T?;
    } else if (T == List<String>) {
      res = _prefs!.getStringList(key) as T?;
    }
    return res ?? defaultValue;
  }

  /// 删除
  ///
  /// [key] 键
  static Future<bool> remove(String key) async {
    if (_prefs == null) {
      throw SpUtilNotInitException();
    }
    bool res = await _prefs!.remove(key);
    return res;
  }

  /// 清空所有缓存
  static Future<bool> clear() async {
    if (_prefs == null) {
      throw SpUtilNotInitException();
    }
    bool res = await _prefs!.clear();
    return res;
  }
}

/// SharedPreferences未初始化异常
///
/// @author zzp
/// @since 2023/9/17
class SpUtilNotInitException implements Exception {
  SpUtilNotInitException({this.msg});

  /// 错误信息
  final String? msg;

  @override
  String toString() {
    return 'SpUtilNotInitException:$msg';
  }
}