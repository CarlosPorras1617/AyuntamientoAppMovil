import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_server/src/providers/temperaturas_state.dart';

class GetLastTemp extends StatefulWidget{  
  @override
  GetLastTempState createState() => GetLastTempState();
}

class GetLastTempState extends State {
@override
void initState(){
  final _temperaturasState = Get.put(TemperaturasState());
  _temperaturasState.obtenerTemperaturas();

  super.initState();
}
Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: GetBuilder<TemperaturasState>(
        builder: (TemperaturasState tempsState){
          return Container(
            height: 200.0,
            width: 500.0,
            child: ListView.builder(
              itemCount: tempsState.temperaturas.length,
              itemBuilder: (BuildContext context, int i){
                final tempsData = tempsState.temperaturas[i];
                final tempLast = tempsState.temperaturas.reversed.last;
                return Text(tempLast.temperatura.toString());
              },
            ),
          );
        },
      ),
    ),
  );
}}