import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_server/src/providers/temperaturas_state.dart';

class RegistroTemps extends StatefulWidget{
  @override
  RegistroTempsState createState() => RegistroTempsState();
}

class RegistroTempsState extends State{
  final _controller = ScrollController();
  bool _cargando = false;
  @override
  void initState(){
    final _temperaturasState = Get.put(TemperaturasState());
    _temperaturasState.obtenerTemperaturas();

    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<TemperaturasState>(
              builder: (TemperaturasState tempsState){
                return Container(
                  height: 200.0,
                  margin: EdgeInsets.only(top: 200.0),
                  child: Card(
                    child: ListView.builder(
                      controller: _controller,
                      itemCount: tempsState.temperaturas.length,
                      itemBuilder: (BuildContext context, int i){
                        final tempsData = tempsState.temperaturas[i];
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
              },
            )
          ],
        ),
      ),
    );
  }
}