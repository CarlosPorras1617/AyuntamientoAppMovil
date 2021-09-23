import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CirculosStatus extends StatelessWidget{
  final Color ? color;
  CirculosStatus({this.color = Colors.grey});
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: _mediaSize.width * 0.015, right: _mediaSize.width * 0.013),
          height: _mediaSize.height * 0.12,
          width: _mediaSize.width * 0.226,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(100.0),
          ),
        ),
        Container(
          height: _mediaSize.height * 0.09,
          width: _mediaSize.width * 0.17,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100.0)
          ),
        )
      ],
    );
  }
}