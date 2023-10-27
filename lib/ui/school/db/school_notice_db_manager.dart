import 'package:csust_edu_system/ass/key_assets.dart';
import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:csust_edu_system/ui/school/jsonbean/school_notice_bean.dart';
import 'package:csust_edu_system/util/db/db_data.dart';

import '../../../util/db/db_manager.dart';

/// 教务通知数据库管理器
///
/// @author zzp
/// @since 2023/10/27
/// @version v1.8.8
class SchoolNoticeDBManager {
  /// 添加教务通知
  ///
  /// [schoolNoticeBean] 教务通知
  static Future<void> insertSchoolNotice(
      SchoolNoticeBean schoolNoticeBean) async {
    await deleteAllSchoolNotice();
    await DBManager.getInstance().rawInsert(
        'insert into $schoolNoticeTableName (ggid, title, time, html) values (?, ?, ?, ?)',
        [
          schoolNoticeBean.ggid,
          schoolNoticeBean.title,
          schoolNoticeBean.time,
          StringAssets.emptyStr
        ]);
  }

  /// 删除所有教务通知
  static Future<void> deleteAllSchoolNotice() async {
    await DBManager.getInstance()
        .rawDelete('delete from $schoolNoticeTableName');
  }

  /// 获取所有教务通知
  static Future<List<SchoolNoticeBean>> getAllSchoolNotice() async {
    final res = await DBManager.getInstance()
        .rawQuery('select * from $schoolNoticeTableName');
    return res.map((json) => SchoolNoticeBean.fromJson(json)).toList();
  }

  /// 更新教务通知html
  ///
  /// [html] html
  /// [ggid] 教务通知id
  static void updateSchoolNoticeHtml(String html, String ggid) {
    DBManager.getInstance().rawUpdate(
        'update $schoolNoticeTableName set html=? where ggid=?', [html, ggid]);
  }

  /// 获取教务通知html
  ///
  /// [ggid] 教务通知id
  static Future<String?> getSchoolNoticeHtmlByGgid(String ggid) async {
    final res = await DBManager.getInstance()
        .rawQuery('select * from $schoolNoticeTableName where ggid=?', [ggid]);
    if (res.isNotEmpty) {
      return res[0][KeyAssets.html].toString();
    } else {
      return null;
    }
  }
}
