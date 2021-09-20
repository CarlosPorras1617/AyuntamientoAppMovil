import 'package:dio/dio.dart';
//import 'package:temp_server/src/models/last_temperatura_model.dart';
import 'package:temp_server/src/models/temperatura_model.dart';

class TemperaturasProvider{
  final String _urlToApi = 'https://ayntamientoapi.herokuapp.com/api/18b20';
  final http = Dio();
  Future<List<TemperaturasModel>> obtenerTemperaturas(int pagina)async{
    final response = await http.get(_urlToApi, queryParameters: {'page': pagina});
    List<dynamic> responseData = response.data['docs'];
    List<dynamic> tempErr = [];
    if (responseData.isNotEmpty) {
      return responseData.map((data) => TemperaturasModel.fromMapJson(data)).toList();
    }else{
      tempErr.add({'_id': 'hola', 'fecha':'2021-09-2020', 'hora':'09-42-09', 'temperatura':0, 'temperaturamedia':0, 'temperaturalta':0});
      return tempErr.map((data) => TemperaturasModel.fromMapJson(data)).toList();
    } 
  }
}