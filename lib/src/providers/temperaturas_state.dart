import 'package:get/get.dart';
import 'package:temp_server/src/models/temperatura_model.dart';
import 'package:temp_server/src/providers/temperaturas_providers.dart';

class TemperaturasState extends GetxController{
  List<TemperaturasModel> temperaturas = [];
  int _paginado = 1;
  final _temperaturasProvider = TemperaturasProvider();
  Future<void> obtenerTemperaturas()async{
    final temps = await _temperaturasProvider.obtenerTemperaturas(_paginado);
    temperaturas.addAll(temps);
    _paginado += 1;
    update();
  }
}