import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_server/src/providers/movs_providers.dart';
import 'package:temp_server/src/providers/movs_state.dart';

class MovimientosPage extends StatefulWidget{
  @override
  _MovimientosPageState createState() => _MovimientosPageState();
}

class _MovimientosPageState extends State{
  final _controller = ScrollController();
  bool _cargando = false;
  @override
  void initState(){
    final _movimientosState = Get.put(MovimientosState());
    _movimientosState.obtenerMovimientos();
    _controller.addListener(() async{ 
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if(_cargando == false){
        setState(() {
          _cargando=true;
        });
        await _movimientosState.obtenerMovimientos();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Movimientos y Capturas'),
      ),
      body: GetMovimientos(controller: _controller,),
    );
  }
}

class GetMovimientos extends StatelessWidget{
  final ScrollController ? controller;
  GetMovimientos({required this.controller});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GetBuilder<MovimientosState>(
            builder: (MovimientosState movState){
              return Container(
                height: 300,
                color: Colors.red,
                child: Card(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: movState.movimientos.length,
                    itemBuilder: (BuildContext context, int i){
                      final movsData = movState.movimientos[i];
                      return Column(
                        children: [
                          Divider(),
                          Text(movsData.fecha!),
                          Text(movsData.hora!),
                          FadeInImage(placeholder: AssetImage('assets/placeholder.jpg'), image: NetworkImage(movsData.foto!))
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