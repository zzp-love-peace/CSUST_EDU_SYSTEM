/// 请求前回调
typedef OnPrepare = void Function();
/// 获取数据成功回调
typedef OnDataSuccess<T> = void Function(T, String);
/// 获取数据失败回调
typedef OnDataFail = void Function(int, String);
/// 请求失败回调
typedef OnFail = void Function(String?);
/// 请求异常回调
typedef OnError = void Function(Exception);
/// 请求结束回调
typedef OnFinish = void Function(bool);
/// 键值对
typedef KeyMap = Map<String, dynamic>;
/// 列表
typedef KeyList = List<dynamic>;
/// 日期选择器回调
typedef DatePickerCallBack = void Function(String term);