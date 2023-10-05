/// List扩展函数
///
/// @author zzp
/// @since 2023/10/3
/// @version v1.8.8
extension ListExtension<T> on List<T> {
  /// 可刷新的添加
  ///
  /// [value] 值
  List<T> addCanNotify(T value) {
    List<T> list = [];
    list.addAll(this);
    list.add(value);
    return list;
  }

  /// 可刷新的插入
  ///
  /// [value] 值
  /// [index] 下标
  List<T> insertCanNotify(T value, int index) {
    List<T> list = [];
    list.addAll(this);
    list.insert(index, value);
    return list;
  }

  /// 可刷新的删除
  ///
  /// [value] 值
  List<T> removeCanNotify(T value) {
    List<T> list = [];
    list.addAll(this);
    list.remove(value);
    return list;
  }

  /// 可刷新的添加list
  ///
  /// [list] 列表
  List<T> addAllCanNotify(List<T> list) {
    List<T> list = [];
    list.addAll(this);
    list.addAll(list);
    return list;
  }

  /// 可刷新的清除
  List<T> clearCanNotify() {
    return [];
  }
}
