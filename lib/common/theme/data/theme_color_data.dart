import 'package:flutter/material.dart';

/// 主题色map
Map<String, MaterialColor> themeColorMap = {
  '天空蓝': Colors.cyan,
  '基础蓝': Colors.blue,
  '深海蓝': Colors.indigo,
  '涧石蓝': _createMaterialColor(const Color(0xFF66A9C9)),
  '星河': _createMaterialColor(const Color(0xFF8BA2CD)),
  '草绿': Colors.green,
  '湖绿': Colors.teal,
  '葱油鸡': _createMaterialColor(const Color(0xFF338277)),
  '牛油果': _createMaterialColor(const Color(0xFF568768)),
  '橄榄': _createMaterialColor(const Color(0xFFBDB76B)),
  '小麦': _createMaterialColor(const Color(0xFFF4A460)),
  '果粒橙': _createMaterialColor(const Color(0xFFE79B59)),
  '夏日柑橘': Colors.orange,
  '巧克力': _createMaterialColor(const Color(0xFFD2691E)),
  '薰衣草': _createMaterialColor(const Color(0xFFDDA0DD)),
  '葡萄': _createMaterialColor(const Color(0xFF8F84C1)),
  '紫罗兰': _createMaterialColor(const Color(0xFFBA55D3)),
  '火龙果': _createMaterialColor(const Color(0xFFBD6298)),
  '梅子': _createMaterialColor(const Color(0xFF975D6D)),
  '樱花': _createMaterialColor(const Color(0xFFEEB4B4)),
  '五花肉': _createMaterialColor(const Color(0xFFFF8C69)),
  '水蜜桃': _createMaterialColor(const Color(0xFFF08080)),
  '草莓': _createMaterialColor(const Color(0xFFD65757)),
  '番茄': _createMaterialColor(const Color(0xFFFF6347)),
  '朱砂': _createMaterialColor(const Color(0xFFCD5C5C)),
};

/// 创建MaterialColor
///
/// [color] 颜色
MaterialColor _createMaterialColor(Color color) {
  List strengths = [.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;
  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1);
  }
  return MaterialColor(color.value, swatch);
}
