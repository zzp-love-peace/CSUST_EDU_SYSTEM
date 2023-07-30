import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoneLottie extends StatelessWidget {
  final String hint;

  const NoneLottie({Key? key, required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Lottie.asset('assets/lotties/lottieLogo.json',
                width: 250, height: 250),
            Text(
              hint,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        )
      ],
    ));
  }
}
