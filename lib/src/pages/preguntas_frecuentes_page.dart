import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreguntasFrecuentes extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Preguntas frecuentes'),
        backgroundColor: Color.fromRGBO(109, 43, 49, 1),
        elevation: 0.0,
      ),
      body: GlowingOverscrollIndicator(
        axisDirection:  AxisDirection.down,
        color: Colors.red.shade900,
        child: ListView(
          children: [
            Text('Preguntas sobre la aplicacion'),
            _PreguntasFrecuentes(tituloPregunta: '¿Por qué la aplicación registra temperatura 0.0?', respuestaPregunta: 'Esto sucederá si el dispositivo deja de registrar temperaturas. Reinicie el dispositivo, y si el error persiste, verifique la conectividad a Internet del dispositivo',),
            _PreguntasFrecuentes(tituloPregunta: '¿Por qué la aplicación se congela al iniciar?', respuestaPregunta: 'Si no se cuenta con acceso a Internet. La aplicación se detendra porque no podra realizar la petición al servidor',),
            _PreguntasFrecuentes(tituloPregunta: '¿Por qué la temperatura no se actualiza?', respuestaPregunta: 'Se mostrara la última temperatura registrada, si no se actualiza, compruebe que el dispositivo funcione correctamente y verifique la conectividad a Internet del dispositivo',),
            _PreguntasFrecuentes(tituloPregunta: '¿Por qué el registro de temperaturas llega a un límite y no se actualiza conforme a las nuevas temperaturas registradas?', respuestaPregunta: 'La aplicación realiza la petición al iniciar, si se desea actualizar las temperaturas, reinicie la aplicación',),
            _PreguntasFrecuentes(tituloPregunta: '¿Por qué la interfaz de movimientos y capturas esta vacía?', respuestaPregunta: 'Si el dispositivo no ha captado ningún movimiento, la interfaz se encontrará vacía',),
            _PreguntasFrecuentes(tituloPregunta: 'Estoy seguro de que el sensor detectó movimiento, pero no se muestra en la aplicación', respuestaPregunta: 'De igual manera, la aplicación realiza la petición al iniciar la app. Reiniciela y comprueba la existencia de este',),
            _PreguntasFrecuentes(tituloPregunta: '¿En dónde se almacenan las imagenes de los movimientos cuando se descargan?', respuestaPregunta: 'La aplicación automaticamente guardará las fotografías en la galeria y en el album "pictures"',),
            _PreguntasFrecuentes(tituloPregunta: 'Denegué el permiso a la aplicación para descargar las fotografías ¿Cómo se lo otorgo?', respuestaPregunta: 'Reinstale la aplicación y permita el acceso cuando la app lo solicite u otorgue el permiso de manera manual en la configuración de su móvil',),
            _PreguntasFrecuentes(tituloPregunta: '¿?', respuestaPregunta: '',),
            _PreguntasFrecuentes(tituloPregunta: '¿?', respuestaPregunta: '',),
            _PreguntasFrecuentes(tituloPregunta: '¿?', respuestaPregunta: '',),
            _PreguntasFrecuentes(tituloPregunta: '¿?', respuestaPregunta: '',),
          ],
        ),
      ),
    );
  }
}

class _PreguntasFrecuentes extends StatelessWidget{
  final String ? tituloPregunta;
  final String ? respuestaPregunta;
  _PreguntasFrecuentes({required this.respuestaPregunta, required this.tituloPregunta});
  @override
  Widget build(BuildContext context) {
    final _mediasize = MediaQuery.of(context).size;
    return Container(
      height: _mediasize.height * 0.19,
      child: Card(
        elevation: 5.0,
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: ListTile(
            title: Text(tituloPregunta!),
            subtitle: Text(respuestaPregunta!),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }
}