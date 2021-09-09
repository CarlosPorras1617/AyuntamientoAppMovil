import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_server/src/models/last_temperatura_model.dart';
import 'package:temp_server/src/providers/last_temperatura_provider.dart';

class GetLastTemp extends StatefulWidget {
  @override
  GetLastTempState createState() => GetLastTempState();
}

class GetLastTempState extends State {

  @override
  Widget build(BuildContext context) {
    var lastTempProvider = LastTemperaturaProvider();
    return FutureBuilder(
            future: lastTempProvider.obtenerLastTemperatura(),
            builder: (BuildContext context,
                AsyncSnapshot<List<LastTemperaturasModel>> snap) {
              if (snap.hasData) {
                final temps = snap.data;
                var tempActual = temps!.last.temperatura;
                return Column(
                  children: [
                    Text(tempActual.toString()),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          tempActual = temps.last.temperatura;
                        });
                      },
                      child: Text('Refrescar Temperatura'),
                    )
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
  }
}
