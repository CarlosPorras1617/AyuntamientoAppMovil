import 'package:flutter/material.dart';
import 'package:temp_server/src/pages/movs_detalles.dart';
import 'package:temp_server/src/pages/movs_page.dart';
import 'package:temp_server/src/pages/home_page.dart';
import 'package:temp_server/src/pages/registro_temperaturas.dart';
import 'package:temp_server/src/pages/temps_desequilibrios.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ayuntamiento App',
      initialRoute: '/',
      //routes from other pages
      routes: {
        '/':(_)=>MenuScroll(),
        '/RegistroTemps':(_)=>RegistroTemps(),
        '/MovimientosPage':(_)=>MovimientosPage(),
        '/DesequilibriosPage':(_)=>DesequilibriosPage(),
        '/DetallesMovimientos':(_)=>DetallesMovimientos()
      },
    );
  }
}