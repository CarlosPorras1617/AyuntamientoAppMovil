import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_server/src/const/temps_const.dart';
import 'package:temp_server/src/models/last_temperatura_model.dart';
import 'package:temp_server/src/providers/last_temperatura_provider.dart';
import 'package:temp_server/src/providers/temperaturas_state.dart';
import 'package:temp_server/src/widgets/circulos_status_widget.dart';

class GetLastTemp extends StatefulWidget {
  @override
  GetLastTempState createState() => GetLastTempState();
}

class GetLastTempState extends State {
  final _temperaturasState = Get.put(TemperaturasState());
  @override
  void initState() {
    _temperaturasState.obtenerTemperaturas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle estilo = TextStyle(fontSize: 30);
    final TextStyle estilo2 = TextStyle(fontSize: 18);
    final _mediaSize = MediaQuery.of(context).size;
    var lastTempProvider = LastTemperaturaProvider();
    lastTempProvider.obtenerLastTemperatura();
    return FutureBuilder(
      future: lastTempProvider.obtenerLastTemperatura(),
      builder: (BuildContext context,
          AsyncSnapshot<List<LastTemperaturasModel>> snap) {
        if (snap.hasData) {
          final temps = snap.data;
          var tempActual = temps!.first.temperatura;
          final horaPrimerDigito = int.parse(temps.first.hora![0]);
          final horaSegundoDigito = int.parse(temps.first.hora![1]);
          return Container(
            width: _mediaSize.width * 0.84,
            height: _mediaSize.height * 0.7,
            child: Column(
              children: [
                SizedBox(height: _mediaSize.height * 0.05),
                Text(
                  'Temperatura',
                  style: estilo,
                ),
                SizedBox(height: _mediaSize.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tempActual.toString(),
                      style:
                          TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '°C',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: _mediaSize.height * 0.01),
                Column(
                  children: [
                    Text(
                      'Ultima Actualización',
                      style: TextStyle(fontSize: 18),
                    ),
                    if (horaPrimerDigito == 0 && horaSegundoDigito <= 9 ||
                        horaPrimerDigito == 1 && horaSegundoDigito <= 1)
                      Text(
                        "${temps.first.hora}  AM",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    else if (horaPrimerDigito == 1 && horaSegundoDigito >= 2 ||
                        horaPrimerDigito == 2 && horaSegundoDigito <= 3)
                      Text(
                        "${temps.first.hora}  PM",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                  ],
                ),
                SizedBox(height: _mediaSize.height * 0.02),
                Column(
                  children: [
                    Text(
                      'Status: ',
                      style: estilo,
                    ),
                    SizedBox(height: _mediaSize.height * 0.01),
                    if (tempActual! < TemperaturasValues.tempOptima &&
                        tempActual != 0)
                      Column(
                        children: [
                          CirculosStatus(color: Colors.green),
                          SizedBox(
                            height: _mediaSize.height *0.02
                          ),
                          Text(
                            'ÓPTIMO',
                            style: estilo,
                          ),
                        ],
                      )
                    else if (tempActual >= TemperaturasValues.tempOptima &&
                        tempActual <= TemperaturasValues.tempCritica)
                      Column(
                        children: [
                          CirculosStatus(color: Colors.yellow),
                          SizedBox(
                            height: _mediaSize.height * 0.02
                          ),
                          Text(
                            'ALERTA',
                            style: estilo,
                          ),
                        ],
                      )
                    else if (tempActual > TemperaturasValues.tempCritica)
                      Column(
                        children: [
                          CirculosStatus(color: Colors.red),
                          SizedBox(
                            height: _mediaSize.height * 0.02
                          ),
                          Text(
                            'CRÍTICO',
                            style: estilo,
                          ),
                        ],
                      )
                    else if (tempActual == 0)
                      Container(
                        margin: EdgeInsets.only(top: _mediaSize.height * 0.05),
                        child: Text(
                          'Compruebe el estado del dispositivo',
                          style: TextStyle(fontSize: 28),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: _mediaSize.height * 0.02),
                ElevatedButton.icon(
                  label: Text('Recargar'),
                  icon: Icon(Icons.replay_outlined),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade900,
                    elevation: 8.0,
                  ),
                  onPressed: () {
                    setState(() {
                      tempActual = temps.last.temperatura;
                    });
                  },
                ),
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
