import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:flutter/material.dart';

import '../../../data/date_info.dart';

/// 日期星期组件View
///
/// @author zzp
/// @since 2023/9/21
/// @version v1.8.8
class DateAndWeekItemView extends StatelessWidget {
  const DateAndWeekItemView(
      {super.key,
      required this.isToday,
      required this.week,
      required this.date});

  /// 是否是今天
  final bool isToday;

  /// 周几
  final String week;

  /// 日期
  final String date;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 3, 3),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: isToday
                ? Theme.of(context).primaryColor.withOpacity(0.2)
                : Colors.transparent,
          ),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Text(week),
              Text(DateInfo.nowWeek != -1 ? date : StringAssets.emptyStr),
              const SizedBox(
                height: 5,
              )
            ],
          ),
        ));
  }
}
