import 'package:logger/logger.dart';

/// Log打印工具类
///
/// @author zzp
/// @since 2023/9/14
/// @version v1.8.8
class Log {

  /// 私有logger变量
  static final _logger = Logger();

  /// debug打印
  ///
  /// [msg] 信息
  static void d(Object? msg) {
    _logger.d(msg.toString());
  }

  /// error/exception打印
  ///
  /// [msg] 信息
  static void e(Object? msg) {
    _logger.e(msg.toString());
  }

  /// warning打印
  ///
  /// [msg] 信息
  static void w(Object? msg) {
    _logger.w(msg.toString());
  }

  /// info打印
  ///
  /// [msg] 信息
  static void i(Object? msg) {
    _logger.i(msg.toString());
  }

  /// trace打印
  ///
  /// [msg] 信息
  static void t(Object? msg) {
    _logger.t(msg.toString());
  }
}