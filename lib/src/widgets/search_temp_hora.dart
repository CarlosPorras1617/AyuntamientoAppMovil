import 'package:flutter/material.dart';
import 'package:temp_server/src/models/temperatura_model.dart';
import 'package:temp_server/src/providers/temperaturas_providers.dart';

class SearchTemperatura extends SearchDelegate {
  final _temperaturaProvider = TemperaturasProvider();
  @override
  List<Widget>? buildActions(BuildContext context) {
    // widgets de lado izquierdo
    return [
      IconButton(onPressed: (){query = '';}, icon: Icon(Icons.close),),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Widget lado derecho
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return (query != '') ? FutureBuilder(
      future: _temperaturaProvider.obtenerTemperaturasPorHora(query),
      builder: (BuildContext context, AsyncSnapshot <TemperaturasModel> snap){
        final temp = snap.data;
        if (snap.hasData) {
          return ListView(
            children: [
              ListTile(
                leading: Text(temp!.temperatura.toString()),
              )
            ],
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ):Container();
  }
  
}