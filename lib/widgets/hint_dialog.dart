import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class HintDialog extends StatelessWidget {
  final String title;
  final String subTitle;

  const HintDialog({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
          width: double.infinity,
          height: 150,
          margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text(subTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black)),
              ),
              Column(
                children: [
                  const Divider(
                    thickness: 2,
                    height: 0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: Text(
                        '确定',
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        SmartDialog.dismiss();
                      },
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
