import 'package:csust_edu_system/data/color_data.dart';
import 'package:csust_edu_system/provider/theme_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeHome extends StatefulWidget {
  const ThemeHome({Key? key}) : super(key: key);

  @override
  State<ThemeHome> createState() => _ThemeHomeState();
}

class _ThemeHomeState extends State<ThemeHome> {
  final List<MaterialColor> _colors = [];
  final List<String> _names = [];
  late final SharedPreferences prefs;
  String _groupValue = '';

  @override
  void initState() {
    super.initState();
    _initColorsAndNames();
    _initGroupValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "主题色",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: _colors.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    setState(() {
                      _groupValue = _names[index];
                      Provider.of<ThemeColorProvider>(context, listen: false)
                          .setTheme(_groupValue);
                      _saveColor(_groupValue);
                    });
                  },
                  child: Padding(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              color: _colors[index],
                              width: 35,
                              height: 35,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            _names[index],
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Radio(
                                activeColor: _colors[index],
                                value: _names[index],
                                groupValue: _groupValue,
                                onChanged: (value) {
                                  setState(() {
                                    _groupValue = value.toString();
                                    Provider.of<ThemeColorProvider>(context,
                                            listen: false)
                                        .setTheme(_groupValue);
                                    _saveColor(_groupValue);
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.only(top: 10),
                  ));
            }));
  }

  _initColorsAndNames() {
    themeColorMap.forEach((key, value) {
      _names.add(key);
      _colors.add(value);
    });
  }

  _initGroupValue() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _groupValue = prefs.getString('color') ?? 'blue';
    });
  }

  _saveColor(String value) async {
    prefs.setString('color', value);
  }
}
