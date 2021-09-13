import 'package:dio/dio.dart';
import 'package:temp_server/src/models/last_temperatura_model.dart';

class LastTemperaturaProvider{
  final String _urlToApi = 'https://integradora-app.herokuapp.com/api/18b20';
  final http = Dio();
  List<LastTemperaturasModel> temperaturas = [];
  Future<List<LastTemperaturasModel>> obtenerLastTemperatura()async{  
    final response = await http.get(_urlToApi);
    List<dynamic> responseData = response.data;
    //print(responseData);
    //print(responseData.length);
    //return responseData.map((data)=> LastTemperaturasModel.fromMapJson(data)).toList();
    if(responseData.isNotEmpty){
      for (int i = 0; i < responseData.length; i++) {
        temperaturas.add(LastTemperaturasModel.fromMapJson(responseData[i]));
      }
    }
    return temperaturas;
  }
}