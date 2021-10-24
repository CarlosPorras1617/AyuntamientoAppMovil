import 'package:dio/dio.dart';
import 'package:temp_server/src/models/last_temperatura_model.dart';

class LastTemperaturaProvider {
  final String _urlToApi = 'https://cloud-temp-project-notpaginate.herokuapp.com/api/temperaturas';
  final http = Dio();
  Future<List<LastTemperaturasModel>> obtenerLastTemperatura() async {
    final response = await http.get(_urlToApi);
    List<dynamic> responseData = response.data;
    List<dynamic> tempErr = [];
    //if the response from api is empty then will create another list with the instance of the temperaturamodel and then will add a default value
    //to avoid some errors and catch em
    if (responseData.isNotEmpty) {
      final lasTemp = responseData.reversed
          .map((data) => LastTemperaturasModel.fromMapJson(data))
          .toList();
      return lasTemp;
    }else{
      tempErr.add({'_id': 'hola', 'fecha':'2021-09-2020', 'hora':'No se han registrado temperaturas', 'temperatura':0, 'temperaturamedia':0, 'temperaturalta':0});
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
