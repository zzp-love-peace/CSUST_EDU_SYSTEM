
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class SelectDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function callback;

  const SelectDialog({Key? key, required this.title, required this.subTitle, required this.callback})
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 20,),
              Text(title, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10,),
              Text(subTitle, style: const TextStyle(color: Colors.black)),
              const SizedBox(height: 20,),
              const Divider(
                thickness: 2,
                height: 0,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      child: Text(
                        '取消',
                        style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        SmartDialog.dismiss();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      thickness: 2,
                      width: 8,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: TextButton(
                        child: Text(
                          '确定',
                          style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () { callback();
                        SmartDialog.dismiss();},
                      ))
                ],
              )
            ],
          )),
    );
  }
}
