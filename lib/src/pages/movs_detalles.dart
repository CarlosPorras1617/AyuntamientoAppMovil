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
            TextButton(
              onPressed: () {
                _GuardarImagen(movimiento!.foto);
              },
              child: Text(
                'Guardar Imagen',
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
            ),
            FadeInImage(
                placeholder: AssetImage('assets/placeholder.jpg'),
                image: NetworkImage(movimiento!.foto!)),
          ],
        ),
      ),
    );
  }

  void _GuardarImagen(urlToImage) async {
    var status = await Permission.storage.request();
    var nombreFoto = movimiento!.fecha;
    var nombreFoto2 = movimiento!.hora;
    if(status.isGranted){
    var response = await Dio()
        .get(urlToImage, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "f= ${nombreFoto} h= ${nombreFoto2}");
    print(result);
    }
  }
}
