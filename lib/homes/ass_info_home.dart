import 'package:cached_network_image/cached_network_image.dart';
import 'package:csust_edu_system/homes/association_home.dart';
import 'package:flutter/material.dart';

import '../utils/my_util.dart';

class AssInfoHome extends StatelessWidget {
  final AssInfo assInfo;

  const AssInfoHome({Key? key, required this.assInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text(
          "社团详情",
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
                height: 30,
              ),
              ClipOval(
                child: CachedNetworkImage(
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    imageUrl: addPrefixToUrl(assInfo.icon),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Container(
                        width: 80,
                        height: 80,
                        color: Theme.of(context).primaryColor)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                assInfo.name,
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
                child: Text(
                  assInfo.introduce,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              Text('公众号：${assInfo.publicNum}', style: const TextStyle(fontSize: 14, color: Colors.black)),
              const SizedBox(height: 10,),
              Text('qq群：${assInfo.qq}', style: const TextStyle(fontSize: 14, color: Colors.black)),
            ],
          )
        ],
      ),
    );
  }
}
