import 'package:dio/dio.dart';
//import 'package:temp_server/src/models/last_temperatura_model.dart';
import 'package:temp_server/src/models/temperatura_model.dart';

class TemperaturasProvider {
  final String _urlToApi = 'https://ayntamientoapi.herokuapp.com/api/18b20';
  final http = Dio();
  Future<List<TemperaturasModel>> obtenerTemperaturas(int pagina) async {
    final response =
        await http.get(_urlToApi, queryParameters: {'page': pagina});
    List<dynamic> responseData = response.data['docs'];
    List<dynamic> tempErr = [];
    return responseData
        .map((data) => TemperaturasModel.fromMapJson(data))
        .toList();
  }

  Future<TemperaturasModel> obtenerTemperaturasPorHora(String query) async {
    final String _urlToApiSearch =
        'https://ayntamientoapi.herokuapp.com/api/18b20';
    final http = Dio();
    final response = await http.get(_urlToApiSearch, queryParameters: {'hora': query});
    final data = response.data['docs'];
    print(data);
    return TemperaturasModel.fromMapJson(data); 
  }
}
