import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_server/src/const/const.dart';
import 'package:temp_server/src/const/temps_const.dart';
//import 'package:temp_server/src/pages/home_page.dart';
//import 'package:temp_server/src/providers/temperaturas_providers.dart';
import 'package:temp_server/src/providers/temperaturas_state.dart';
import 'package:temp_server/src/widgets/color_fondo_widget.dart';
import 'package:temp_server/src/widgets/divider_vertical_widget.dart';

class RegistroTemps extends StatefulWidget {
  @override
  RegistroTempsState createState() => RegistroTempsState();
}

class RegistroTempsState extends State {
  final _controller = ScrollController();
  bool _cargando = false;
  final _temperaturasState = Get.put(TemperaturasState());
  @override
  void initState() {
    _temperaturasState.obtenerTemperaturas();
    _controller.addListener(() async {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (_cargando == false) {
          setState(() {
            _cargando = true;
          });
          await _temperaturasState.obtenerTemperaturas();
          setState(() {
            _cargando = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Registro de Temperaturas'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(88, 170, 224, 1),
          elevation: 0.0,
        ),
        body: Stack(
          children: [
            ColorFondo(),
            Positioned(
              left: _mediaSize.width * 0.23,
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/placeholder.jpg'),
                  ),
                ),
              ),
            ),
            GetTemps(controller: _controller),
            if (_cargando == true)
              //while getting more temperatures
              Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            else if (_cargando == false)
              Container()
          ],
        ));
  }
}

class GetTemps extends StatelessWidget {
  final ScrollController? controller;
  final TextStyle estiloText = TextStyle(fontSize: 18);

  GetTemps({required this.controller});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GetBuilder<TemperaturasState>(
            builder: (TemperaturasState tempsState) {
              return Container(
                height: double.maxFinite,
                margin: EdgeInsets.only(top: 200.0),
                child: Card(
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: controller,
                    itemCount: tempsState.temperaturas.length,
                    itemBuilder: (BuildContext context, int i) {
                      final tempsData = tempsState.temperaturas[i];
                      final horaPrimerDigito = int.parse(tempsData.hora![0]);
                      final horaSegundoDigito = int.parse(tempsData.hora![1]);
                      return Column(
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
                                  "${tempsData.hora}  AM",
                                  style: estiloText,
                                )
                              else if (horaPrimerDigito == 1 &&
                                      horaSegundoDigito >= 2 ||
                                  horaPrimerDigito == 2 &&
                                      horaSegundoDigito <= 3)
                                Text(
                                  "${tempsData.hora}  PM",
                                  style: estiloText,
                                ),
                              DividerVertical(),
                              if (tempsData.temperatura! <
                                  TemperaturasValues.tempOptima)
                                Text('${tempsData.temperatura.toString()} °C', style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),)
                              else if (tempsData.temperatura! >=
                                      TemperaturasValues.tempOptima &&
                                  tempsData.temperatura! <=
                                      TemperaturasValues.tempCritica)
                                Text('${tempsData.temperatura.toString()} °C', style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.bold),)
                              else if (tempsData.temperatura! >
                                  TemperaturasValues.tempCritica)
                                Text('${tempsData.temperatura.toString()} °C', style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),)
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
/*var lastTempProvider = LastTemperaturaProvider();
    return FutureBuilder(
      future: lastTempProvider.obtenerLastTemperatura(),
      builder: (BuildContext context,
          AsyncSnapshot<List<LastTemperaturasModel>> snap) {
            if (snap.hasData) {
                final temps = snap.data;
                return Container(
                  height: 200.0,
                  margin: EdgeInsets.only(top: 200.0),
                  child: Card(
                    child: ListView.builder(
                      itemCount: temps!.length,
                      itemBuilder: (BuildContext context, int i){
                        final tempsData = temps[i];
                        return Column(
                          children: [
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(tempsData.fecha!),
                                Text(tempsData.hora!),
                                Text(tempsData.temperatura!.toString())
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                );
            }
            return CircularProgressIndicator();
          },
    );*/