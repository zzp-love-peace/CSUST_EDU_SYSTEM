/// 请求前回调
typedef OnPrepare = void Function();

/// 请求完成回调
typedef OnComplete = void Function();

/// 获取数据成功回调
///
/// [data] 数据
/// [msg] 成功信息
typedef OnDataSuccess<T> = void Function(T data, String msg);

/// 获取数据失败回调
///
/// [code] 错误码
/// [msg] 错误信息
typedef OnDataFail = void Function(int code, String msg);

/// 请求失败回调
///
/// [msg] 错误信息
typedef OnFail = void Function(String? msg);

/// 请求异常回调
///
/// [exception] 异常
typedef OnError = void Function(Exception exception);

/// 请求结束回调
///
/// [isSuccess] 获取数据是否成功
typedef OnFinish = void Function(bool isSuccess);

/// 键值对
typedef KeyMap = Map<String, dynamic>;

/// 列表
typedef KeyList = List<dynamic>;

/// 学期选择器回调
///
/// [term] 学期
typedef DatePickerCallBack = void Function(String term);

/// 通用选择器确认回调
///
/// [value] 选择的值
/// [index] 选择的下标
typedef CommonPickerConfirm<T> = void Function(T value, int index);

/// 电话卡选择器回调
///
/// [value] 值
typedef TelephonePickerCallBack = void Function(dynamic value);
