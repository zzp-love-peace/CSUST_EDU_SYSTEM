/// 事务Item Model
///
/// @author zzp
/// @since 2023/9/23
/// @version v1.8.8
class TransactionItemModel {
  TransactionItemModel({this.isCourseAddActive = false});

  /// 是否处于可以添加课程的状态
  bool isCourseAddActive;
}
