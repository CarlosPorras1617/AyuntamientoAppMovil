import 'package:get/get.dart';
import 'package:temp_server/src/models/movs_model.dart';
import 'package:temp_server/src/providers/movs_providers.dart';

class MovimientosState extends GetxController{
  List<MovimientosModel> movimientos = [];
  int _paginado = 1;
  final _movimientosProviders = MovimientosProvider();
  Future<void> obtenerMovimientos() async{
    final movs = await _movimientosProviders.obtenerMovimientos(_paginado);
    movimientos.addAll(movs);
    _paginado += 1;
    update();
  }
}