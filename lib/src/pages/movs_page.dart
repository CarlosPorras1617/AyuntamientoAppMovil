import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:temp_server/src/models/movs_model.dart';
import 'package:temp_server/src/providers/movs_providers.dart';
import 'package:temp_server/src/providers/movs_state.dart';
import 'package:temp_server/src/widgets/color_fondo_widget.dart';

class MovimientosPage extends StatefulWidget {
  @override
  _MovimientosPageState createState() => _MovimientosPageState();
}

class _MovimientosPageState extends State {
  final _controller = ScrollController();
  bool _cargando = false;
  @override
  void initState() {
    final _movimientosState = Get.put(MovimientosState());
    _movimientosState.obtenerMovimientos();
    _controller.addListener(() async {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (_cargando == false) {
          setState(() {
            _cargando = true;
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
          centerTitle: true,
          backgroundColor: Color.fromRGBO(109, 43, 49, 1),
        ),
        body: Stack(
          children: [
            ColorFondo(),
            GetMovimientos(
              controller: _controller,
            )
          ],
        ));
  }
}

class GetMovimientos extends StatelessWidget {
  final ScrollController? controller;
  GetMovimientos({required this.controller});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GetBuilder<MovimientosState>(
            builder: (MovimientosState movState) {
              return GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Colors.red.shade900,
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  controller: controller,
                  itemCount: movState.movimientos.length,
                  itemBuilder: (BuildContext context, int i) {
                    return _ElementosInCard(
                      movs: movState.movimientos[i],
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class _ElementosInCard extends StatelessWidget {
  final MovimientosModel? movs;
  _ElementosInCard({required this.movs});
  @override
  Widget build(BuildContext context) {
    final horaPrimerDigito = int.parse(movs!.hora![0]);
    final horaSegundoDigito = int.parse(movs!.hora![1]);
    final _mediaSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/DetallesMovimientos', arguments: movs);
      },
      child: Container(
        height: _mediaSize.height * 0.17,
        child: Card(
          elevation: 5.0,
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage(
                  fadeOutDuration: Duration(milliseconds: 300),
                  placeholder: AssetImage('assets/placeholder2.png'),
                  image: NetworkImage(movs!.foto!),
                ),
              ),
              title: Text('Movimiento Detectado'),
              subtitle: (horaPrimerDigito == 0 && horaPrimerDigito <= 9 || horaPrimerDigito == 1 && horaSegundoDigito <= 1) ? Text('Fecha: ${movs!.fecha} \nHora: ${movs!.hora} AM') :Text('Fecha: ${movs!.fecha} \nHora: ${movs!.hora} PM'),
              isThreeLine: true,
              horizontalTitleGap: 10,
              contentPadding: EdgeInsets.only(left: _mediaSize.width * 0.05),
            ),
          ),
        ),
      ),
    );
  }
}
