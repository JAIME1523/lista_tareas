import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final Color color;
  final String text;
  final Function? onPress;

  const BotonAzul(
      {super.key,
      required this.color,
      required this.text,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 2, shape: const StadiumBorder(), primary: color),
        onPressed: onPress != null
            ? () {
                onPress!();
              }
            : null,
        child: SizedBox(
            height: 55,
            width: double.infinity,
            child: Center(
                child: Text(text, style: const TextStyle(fontSize: 17)))));
  }
}
