import 'package:flutter/material.dart';

class ColorFondo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Color.fromRGBO(88, 170, 224, 1)),
    );
  }
}