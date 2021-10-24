import 'package:dio/dio.dart';
import 'package:temp_server/src/models/temperatura_model.dart';

class TemperaturasProvider {
  final String _urlToApi = 'https://cloud-temp-project.herokuapp.com/api/temperaturas';
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
        'https://cloud-temp-project.herokuapp.com/api/temperaturas';
    final http = Dio();
    final response = await http.get(_urlToApiSearch, queryParameters: {'hora': query});
    final data = response.data['docs'];
    print(data);
    return TemperaturasModel.fromMapJson(data); 
  }
}
