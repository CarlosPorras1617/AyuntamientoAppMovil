import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_server/src/models/temperatura_model.dart';
//import 'package:temp_server/src/providers/las_temperatura_state.dart';
import 'package:temp_server/src/providers/last_temperatura_provider.dart';
//import 'package:get/get.dart';
//import 'package:temp_server/src/providers/las_temperatura_state.dart';
//import 'package:temp_server/src/providers/temperaturas_state.dart';

class GetLastTemp extends StatefulWidget{  
  @override
  GetLastTempState createState() => GetLastTempState();
}

class GetLastTempState extends State {
@override
void initState(){

  super.initState();
}
@override
Widget build(BuildContext context) {
  var lastTempProvider = LastTemperaturaProvider();
  return FutureBuilder(
    future: lastTempProvider.obtenerLastTemperatura(),
    builder: (BuildContext context, AsyncSnapshot<List<TemperaturasModel>> snap){
      if (snap.hasData) {
        final temps = snap.data;
        var tempActual = temps!.last.temperatura;
        return Column(
          children: [
            Text(tempActual.toString()),
            ElevatedButton(onPressed: (){ setState(() {
              tempActual = temps.last.temperatura;
            });}, child:Text('Refrescar Temperatura'))
          ],
        );
      }
      return Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    },
  );
}}