import 'package:csust_edu_system/ass/string_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 带输入框带Dialog
///
/// @author zzp
/// @since 2023/9/24
/// @version v1.8.8
class EditDialog extends StatefulWidget {
  EditDialog(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.callback})
      : super(key: key);

  /// 标题
  final String title;

  /// 副标题
  final String subTitle;

  /// 确定后的回调
  final Function(String) callback;

  /// 控制器
  final _controller = TextEditingController();

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {

  /// 异常字符串
  String? _error;

  @override
  void dispose() {
    super.dispose();
    widget._controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(widget.title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(30, 15, 30, 5),
                        child: TextField(
                          controller: widget._controller,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          // style: const TextStyle(fontSize: 16),
                          maxLength: 10,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            labelText: widget.subTitle,
                            errorText: _error,
                          ),
                        )),
                    // const SizedBox(height: 20,),
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
                              StringAssets.cancel,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor),
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
                                StringAssets.ok,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor),
                              ),
                              onPressed: () {
                                if (widget._controller.text.isEmpty) {
                                  setState(() {
                                    _error = StringAssets.cannotEmpty;
                                  });
                                } else {
                                  widget.callback(widget._controller.text);
                                  SmartDialog.dismiss();
                                }
                              },
                            ))
                      ],
                    )
                  ],
                )),
          ],
        )
    );
  }
}
