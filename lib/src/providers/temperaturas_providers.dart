import 'package:dio/dio.dart';
import 'package:temp_server/src/models/temperatura_model.dart';

class TemperaturasProvider{
  final String _urlToApi = 'https://ayntamientoapi.herokuapp.com/api/18b20';
  final http = Dio();

  Future<List<TemperaturasModel>> obtenerTemperaturas(int pagina)async{
    final response = await http.get(_urlToApi, queryParameters: {'page': pagina});
    List<dynamic> responseData = response.data['docs'];
    //print(responseData);
    //print(responseData.length);
    return responseData.reversed.map((data) => TemperaturasModel.fromMapJson(data)).toList();
  }
}