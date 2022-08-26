import 'package:csust_edu_system/homes/recruit_home.dart';
import 'package:flutter/material.dart';

class RecInfoHome extends StatelessWidget {
  final Recruit recruit;
  const RecInfoHome({Key? key, required this.recruit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text(
          "兼职详情",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                recruit.title,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
                child: Text(
                  recruit.content,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Text(
                '工作日期：${recruit.workDate}',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '详细时间：${recruit.workTime}',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              SelectableText(
                '联系方式：${recruit.contact}',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '免责声明：${recruit.duty}',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
