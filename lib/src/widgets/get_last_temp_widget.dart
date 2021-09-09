import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_server/src/const/temps_const.dart';
import 'package:temp_server/src/models/last_temperatura_model.dart';
import 'package:temp_server/src/providers/last_temperatura_provider.dart';

class GetLastTemp extends StatefulWidget {
  @override
  GetLastTempState createState() => GetLastTempState();
}

class GetLastTempState extends State {
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;
    var lastTempProvider = LastTemperaturaProvider();
    return FutureBuilder(
      future: lastTempProvider.obtenerLastTemperatura(),
      builder: (BuildContext context,
          AsyncSnapshot<List<LastTemperaturasModel>> snap) {
        if (snap.hasData) {
          final temps = snap.data;
          var tempActual = temps!.last.temperatura;
          return Container(
            width: _mediaSize.width * 0.84,
            height: _mediaSize.height * 0.6,
            child: Column(
              children: [
                SizedBox(height: _mediaSize.height * 0.05),
                Text('Temperatura', style: TextStyle(fontSize: 30),),
                Text('Actual', style: TextStyle(fontSize: 30),),
                SizedBox(height: _mediaSize.height * 0.03),
                Text(
                  '${tempActual.toString()} °C',
                  style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      tempActual = temps.last.temperatura;
                    });
                  },
                  child: Text('Refrescar Temperatura'),
                ),
                if (tempActual! < TemperaturasValues.tempOptima)
                  Container(
                    margin: EdgeInsets.only(top: _mediaSize.height *0.5),
                    child: Text('Temperatura Optima'),
                  )
                else if (tempActual! >= TemperaturasValues.tempOptima &&
                    tempActual! <= TemperaturasValues.tempCritica)
                  Container(
                    margin: EdgeInsets.only(top: _mediaSize.height * 0.05),
                    child: Text('Temperatura en alerta'),
                  )
                else if (tempActual! > TemperaturasValues.tempCritica)
                  Container(
                    margin: EdgeInsets.only(top: _mediaSize.height *0.05),
                    child: Text('Temperatura Critica', style: TextStyle(fontSize:  28),),
                  )
              ],
            ),
          );
        }
        return Container(
          width: _mediaSize.width * 0.84,
          height: _mediaSize.height * 0.6,
          child: Stack(
            children: [
              Positioned(
                left: _mediaSize.width * 0.37,
                bottom: _mediaSize.height * 0.5,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
