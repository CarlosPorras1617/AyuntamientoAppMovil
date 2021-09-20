import 'package:dio/dio.dart';
import 'package:temp_server/src/models/last_temperatura_model.dart';

class LastTemperaturaProvider {
  final String _urlToApi = 'https://integradora-app.herokuapp.com/api/18b20';
  final http = Dio();
  Future<List<LastTemperaturasModel>> obtenerLastTemperatura() async {
    final response = await http.get(_urlToApi);
    List<dynamic> responseData = response.data;
    List<dynamic> tempErr = [];
    if (responseData.isNotEmpty) {
      final lasTemp = responseData.reversed
          .map((data) => LastTemperaturasModel.fromMapJson(data))
          .toList();
      return lasTemp;
    }else{
      tempErr.add({'_id': 'hola', 'fecha':'2021-09-2020', 'hora':'09-42-09', 'temperatura':0, 'temperaturamedia':0, 'temperaturalta':0});
      return tempErr.map((data) => LastTemperaturasModel.fromMapJson(data)).toList();
    }

    /*if(responseData.isNotEmpty){
      for (int i = 0; i < responseData.length; i++) {
        temperaturas.add(LastTemperaturasModel.fromMapJson(responseData[i]));
      }
    }*/
    //return temperaturas;
  }
}
