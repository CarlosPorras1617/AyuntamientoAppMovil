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
import 'package:temp_server/src/widgets/search_temp_hora.dart';

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
    //reload 10 temperatures from the paginated api when listview gets to limit
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
        backgroundColor: Color.fromRGBO(109, 43, 49, 1),
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          ColorFondo(),
          GetTemps(controller: _controller),
          if (_cargando == true)
            //while getting more temperatures
            Container(
              margin: EdgeInsets.only(top: _mediaSize.height * 0.2),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.red.shade900,
                ),
              ),
            )
          else if (_cargando == false)
            Container()
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: (){
          showSearch(context: context, delegate: SearchTemperatura());
        },
        child: Icon(Icons.search),
        backgroundColor: Colors.red,
      ),*/
    );
  }
}

class GetTemps extends StatelessWidget {
  final ScrollController? controller;
  final TextStyle estiloText = TextStyle(fontSize: 18);

  GetTemps({required this.controller});
  @override
  Widget build(BuildContext context) {
    final _mediasize = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          GetBuilder<TemperaturasState>(
            builder: (TemperaturasState tempsState) {
              return Container(
                height: double.maxFinite,
                margin: EdgeInsets.only(top: _mediasize.height *0.07),
                child: Card(
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: Colors.red.shade900,
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
                            (tempsData.temperatura != 0)
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                              TemperaturasValues.tempOptima &&
                                          tempsData.temperatura != 0)
                                        Text(
                                          '${tempsData.temperatura.toString()} °C',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      else if (tempsData.temperatura! >=
                                              TemperaturasValues.tempOptima &&
                                          tempsData.temperatura! <=
                                              TemperaturasValues.tempCritica)
                                        Text(
                                          '${tempsData.temperatura.toString()} °C',
                                          style: TextStyle(
                                              color: Colors.yellow,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      else if (tempsData.temperatura! >
                                          TemperaturasValues.tempCritica)
                                        Text(
                                          '${tempsData.temperatura.toString()} °C',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                    ],
                                  )
                                : Text('No hay datos')
                          ],
                        );
                      },
                    ),
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
