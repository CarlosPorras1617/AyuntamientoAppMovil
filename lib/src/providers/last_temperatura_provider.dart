import 'package:dio/dio.dart';
import 'package:temp_server/src/models/temperatura_model.dart';

class LastTemperaturaProvider{
  final String _urlToApi = 'https://integradora-app.herokuapp.com/api/18b20';
  final http = Dio();

  Future<List<TemperaturasModel>> obtenerLastTemperatura()async{
    final response = await http.get(_urlToApi);
    List<dynamic> responseData = response.data;
    //print(responseData);
    //print(responseData.length);
    return responseData.map((data)=> TemperaturasModel.fromMapJson(data)).toList();
  }
}