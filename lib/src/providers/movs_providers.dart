import 'package:dio/dio.dart';
import 'package:temp_server/src/models/movs_model.dart';

class MovimientosProvider{
  final String _urlToApi = 'https://ayntamientoapi.herokuapp.com/api/movimientos';
  final http = Dio();
  List<MovimientosModel> movimientos = [];
  Future<List<MovimientosModel>> obtenerMovimientos(int pagina)async{
    final response = await http.get(_urlToApi, queryParameters: {'page': pagina});
    List<dynamic> responseData = response.data['docs'];
    if (responseData.isNotEmpty) {
      for (var i = 0; i < responseData.length; i++) {
        movimientos.add(MovimientosModel.fromMapJson(responseData[i]));
      }
    }
    return movimientos;
  }
}