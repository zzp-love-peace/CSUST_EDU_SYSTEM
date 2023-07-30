import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class SelectDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function callback;
  final String positiveText;
  final String negativeText;

  const SelectDialog({Key? key,
    required this.title,
    required this.subTitle,
    required this.callback,
    this.positiveText = '确定',
    this.negativeText = '取消'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Padding(padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Text(
                      subTitle, style: const TextStyle(color: Colors.black)),),
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
                          negativeText,
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme
                                  .of(context)
                                  .primaryColor),
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
                            positiveText,
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme
                                    .of(context)
                                    .primaryColor),
                          ),
                          onPressed: () {
                            callback();
                            SmartDialog.dismiss();
                          },
                        ))
                  ],
                )
              ],
            )),
      ],)
    );
  }
}
