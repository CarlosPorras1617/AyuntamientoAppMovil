import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:temp_server/src/models/movs_model.dart';
import 'package:temp_server/src/widgets/color_fondo_widget.dart';

class DetallesMovimientos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MovimientosModel movimientos =
        ModalRoute.of(context)!.settings.arguments as MovimientosModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle Movimiento'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(109, 43, 49, 1),
      ),
      body: Stack(
        children: [
          ColorFondo(),
          _FotoMovimiento(
            movimiento: movimientos,
          )
        ],
      ),
    );
  }
}

class _FotoMovimiento extends StatelessWidget {
  final MovimientosModel? movimiento;
  final String _imagepath = '';
  _FotoMovimiento({required this.movimiento});
  @override
  Widget build(BuildContext context) {
    final _mediasize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          top: _mediasize.height * 0.05,
          right: _mediasize.width * 0.05,
          left: _mediasize.width * 0.05),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Column(
          children: [
            Text(
              'Fotografia Capturada',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
            SizedBox(
              height: _mediasize.height * 0.05,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FadeInImage(
                placeholder: AssetImage('assets/placeholder.jpg'),
                image: NetworkImage(movimiento!.foto!),
              ),
            ),
            SizedBox(
              height: _mediasize.height * 0.05,
            ),
            TextButton(
              onPressed: () {
                //_GuardarImagen(movimiento!.foto);
                _GuardarImagen(movimiento!.foto, context);
              },
              child: Text(
                'Guardar Imagen',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10.0),
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
            ),
            SizedBox(
              height: _mediasize.height * 0.03,
            ),
            _CuadroBlanco(movimiento: movimiento),
          ],
        ),
      ),
    );
  }

  void _GuardarImagen(urlToImage, context) async {
    var status = await Permission.storage.request();
    var nombreFoto = movimiento!.fecha;
    var nombreFoto2 = movimiento!.hora;
    if (status.isGranted) {
      var response = await Dio()
          .get(urlToImage, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "f= ${nombreFoto} h= ${nombreFoto2}");
      final resultado = Map<String, dynamic>.from(result);
      final comparacion = resultado['isSuccess'];
      //print(resultado['isSuccess']);
      if (comparacion == true) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Status'),
            content:
                Text('Fotografia guardada correctamente en galeria - pictures'),
          ),
        );
      } else if (comparacion == false) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Status'),
            content: Text('Fotografia no guardada en galeria'),
          ),
        );
      }
    }
  }
}

class _CuadroBlanco extends StatelessWidget {
  final MovimientosModel? movimiento;
  _CuadroBlanco({required this.movimiento});
  @override
  Widget build(BuildContext context) {
    final horaPrimerDigito = int.parse(movimiento!.hora![0]);
    final horaSegundoDigito = int.parse(movimiento!.hora![1]);
    final _mediaSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ]),
            height: _mediaSize.height * 0.24,
            width: _mediaSize.width * 0.9,
            child: Column(
              children: [
                SizedBox(
                  height: _mediaSize.height * 0.01,
                ),
                Text(
                  'Fecha del movimiento: ',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(
                  height: _mediaSize.height * 0.02,
                ),
                Text(
                  movimiento!.fecha!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: _mediaSize.height * 0.04,
                ),
                Text(
                  'Hora del movimiento: ',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                SizedBox(
                  height: _mediaSize.height * 0.02,
                ),
                if (horaPrimerDigito == 0 && horaSegundoDigito <= 9 ||
                    horaPrimerDigito == 1 && horaSegundoDigito <= 1)
                  Text(
                    "${movimiento!.hora} AM",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                else if (horaPrimerDigito == 1 && horaSegundoDigito >= 2 ||
                    horaPrimerDigito == 2 && horaSegundoDigito <= 3)
                  Text(
                    "${movimiento!.hora} PM",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
