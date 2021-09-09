import 'package:flutter/material.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:temp_server/src/widgets/get_last_temp_widget.dart';

class MenuScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: [
          InterfazHome(),
          BotonesNavegacion(),
        ],
        fullTransitionValue: 500,
        enableSideReveal: false,
      ),
    );
  }
}

class InterfazHome extends StatelessWidget {
  final DateTime now = DateTime.now();
  final DateTime eastcost =
      dateTimeToZone(zone: 'PDT', datetime: DateTime.now());
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;
    final String formatted = formatter.format(eastcost);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Center(
          child: Column(
            children: [
              Text(
                'Temperatura',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                formatted,
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ColorFondo(),
          Positioned(
            bottom: _mediaSize.height * 0.15,
            left: _mediaSize.width * 0.08,
            child: Stack(
              children: [
                ContenedorCentro(),
                Positioned(
                  bottom: _mediaSize.height * 0.35,
                  left: _mediaSize.width * 0.18,
                  child: GetLastTemp(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BotonesNavegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Color.fromRGBO(88, 170, 224, 1)),
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: _mediaSize.height * 0.05),
          width: _mediaSize.height * 0.25,
          height: _mediaSize.height * 1,
          child: Column(
            children: [
              Container(
                height: _mediaSize.height * 0.3,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/placeholder.jpg'))),
              ),
              _BtnMenu(
                route: '/RegistroTemps',
                title: 'Registro De Temperaturas',
              ),
              SizedBox(height: _mediaSize.height * 0.05),
              _BtnMenu(
                route: '/GraficaTemps',
                title: 'Grafica',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BtnMenu extends StatelessWidget {
  String? route;
  String? image;
  String? title;
  _BtnMenu({required this.route, this.image, required this.title});
  @override
  Widget build(BuildContext context) {
    final _mediaSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route!);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Color.fromRGBO(252, 96, 100, 1),
        child: Container(
          margin: EdgeInsets.all(_mediaSize.height * 0.03),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: _mediaSize.width * 0.13,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/placeholder.jpg'),
                    ),
                    SizedBox(
                      height: _mediaSize.height * 0.02,
                    ),
                    Text(
                      title!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ColorFondo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Color.fromRGBO(88, 170, 224, 1)),
    );
  }
}

class ContenedorCentro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        height: 400.0,
        width: 300.0,
        color: Colors.white,
      ),
    );
  }
}
