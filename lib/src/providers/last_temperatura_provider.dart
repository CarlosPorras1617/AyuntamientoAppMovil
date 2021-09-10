import 'package:dio/dio.dart';
import 'package:temp_server/src/models/last_temperatura_model.dart';

class LastTemperaturaProvider{
  final String _urlToApi = 'https://integradora-app.herokuapp.com/api/18b20';
  final http = Dio();

  Future<List<LastTemperaturasModel>> obtenerLastTemperatura()async{
    final response = await http.get(_urlToApi);
    List<dynamic> responseData = response.data;
    //print(responseData);
    //print(responseData.length);
    return responseData.map((data)=> LastTemperaturasModel.fromMapJson(data)).toList();
  }
}