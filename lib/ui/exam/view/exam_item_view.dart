import 'package:flutter/material.dart';

import '../../../data/date_info.dart';
import '../jsonbean/exam_bean.dart';

/// 考试列表Item类
///
/// @author wk
/// @since 2023/11/4
/// @version v1.8.8
class ExamItemView extends StatelessWidget {
  const ExamItemView({super.key, required this.examBean});

  /// 考试详情数据
  final ExamBean examBean;

  @override
  Widget build(BuildContext context) {
    // 是否是今天
    bool isToday = false;
    if (examBean.date == DateInfo.nowDate) isToday = true;
    return Card(
        color: isToday ? Theme.of(context).primaryColor : Colors.white38,
        margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    '${examBean.examDate[0]}/',
                    style: TextStyle(
                        fontSize: 16,
                        color: isToday ? Colors.white : Colors.black),
                  ),
                  Text('${examBean.examDate[1]}/${examBean.examDate[2]}',
                      style: TextStyle(
                          fontSize: 16,
                          color: isToday ? Colors.white : Colors.black))
                ],
              ),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Text(
                        examBean.examName,
                        style: TextStyle(
                            fontSize: 16,
                            color: isToday ? Colors.white : Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text('${examBean.startTime}-${examBean.endTime}',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isToday ? Colors.white : Colors.black)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(examBean.examAddress,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isToday ? Colors.white : Colors.black)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
