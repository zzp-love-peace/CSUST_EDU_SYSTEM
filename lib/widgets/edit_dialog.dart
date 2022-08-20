import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class EditDialog extends StatefulWidget {
  final String title;
  final String subTitle;
  final Function(String) callback;
  final _controller = TextEditingController();

  EditDialog({Key? key,
    required this.title,
    required this.subTitle,
    required this.callback})
      : super(key: key);

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {

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
      child: Container(
          width: double.infinity,
          height: 200,
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
                        '取消',
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
                          '确定',
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme
                                  .of(context)
                                  .primaryColor),
                        ),
                        onPressed: () {
                          if (widget._controller.text.isEmpty) {
                            setState(() {
                              _error = '不能为空';
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
    );
  }
}
