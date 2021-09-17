import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temp_server/src/const/const.dart';
import 'package:temp_server/src/models/last_temperatura_model.dart';
import 'package:temp_server/src/providers/last_temperatura_provider.dart';
import 'package:temp_server/src/widgets/color_fondo_widget.dart';
import 'package:temp_server/src/widgets/divider_vertical_widget.dart';

class DesequilibriosPage extends StatefulWidget {
  DesequilibriosPageState createState() => DesequilibriosPageState();
}

class DesequilibriosPageState extends State {
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Temperaturas Desequilibrio'),
        backgroundColor: Color.fromRGBO(109, 43, 49, 1),
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          ColorFondo(),
          _GetTempsDesequilibrio(),
        ],
      ),
    );
  }
}

class _GetTempsDesequilibrio extends StatelessWidget {
  final tempsProvider = LastTemperaturaProvider();
  final TextStyle estiloText = TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tempsProvider.obtenerLastTemperatura(),
      builder: (BuildContext context,
          AsyncSnapshot<List<LastTemperaturasModel>> snap) {
        if (snap.hasData) {
          final temps = snap.data;
          return Container(
            height: double.maxFinite,
            margin: EdgeInsets.only(top: 50.0),
            child: Card(
              child: ListView.builder(
                itemCount: temps!.length,
                itemBuilder: (BuildContext context, int i) {
                  final tempsData = temps[i];
                  final horaPrimerDigito = int.parse(tempsData.hora![0]);
                  final horaSegundoDigito = int.parse(tempsData.hora![1]);
                  return (tempsData.temperatura! >=
                          TemperaturasValues.tempOptima)
                      ? Column(
                          children: [
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  tempsData.fecha!,
                                  style: estiloText,
                                ),
                                DividerVertical(),
                                if (horaPrimerDigito == 0 &&
                                        horaSegundoDigito <= 9 ||
                                    horaPrimerDigito == 1 &&
                                        horaSegundoDigito <= 1)
                                  Text(
                                    "${tempsData.hora} AM",
                                    style: estiloText,
                                  )
                                else if (horaPrimerDigito == 1 &&
                                        horaSegundoDigito >= 2 ||
                                    horaPrimerDigito == 2 &&
                                        horaSegundoDigito <= 3)
                                  Text(
                                    "${tempsData.hora} PM",
                                    style: estiloText,
                                  ),
                                DividerVertical(),
                                Text(
                                  "${tempsData.temperatura!} C°".toString(),
                                  style: estiloText,
                                ),
                                DividerVertical(),
                                if (tempsData.temperatura! >=
                                        TemperaturasValues.tempOptima &&
                                    tempsData.temperatura! <=
                                        TemperaturasValues.tempCritica)
                                  Text(
                                    'ALERTA',
                                    style: TextStyle(
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )
                                else if(tempsData.temperatura! > TemperaturasValues.tempCritica)
                                  Text('CRÍTICO',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),)
                              ],
                            )
                          ],
                        )
                      : Container();
                },
              ),
            ),
          );
        }
        return Container(
          height: double.maxFinite,
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 50.0),
          child: Card(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
