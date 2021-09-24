import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreguntasFrecuentes extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Preguntas frecuentes'),
        backgroundColor: Color.fromRGBO(109, 43, 49, 1),
        elevation: 0.0,
      ),
    );
  }
}