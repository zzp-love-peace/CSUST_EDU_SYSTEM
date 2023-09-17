import 'package:logger/logger.dart';

/// Log打印工具类
///
/// @author zzp
/// @since 2023/9/14
class Log {

  /// 私有logger变量
  static final _logger = Logger();

  /// debug打印
  ///
  /// [msg] 信息
  static void d(String? msg) {
    _logger.d(msg);
  }

  /// error/exception打印
  ///
  /// [msg] 信息
  static void e(String? msg) {
    _logger.e(msg);
  }

  /// warning打印
  ///
  /// [msg] 信息
  static void w(String? msg) {
    _logger.w(msg);
  }

  /// info打印
  ///
  /// [msg] 信息
  static void i(String? msg) {
    _logger.i(msg);
  }

  /// trace打印
  ///
  /// [msg] 信息
  static void t(String? msg) {
    _logger.t(msg);
  }
}