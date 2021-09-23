import 'package:flutter/material.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:temp_server/src/widgets/color_fondo_widget.dart';
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
                GetLastTemp(),
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
      decoration: BoxDecoration(color: Color.fromRGBO(109, 43, 49, 1)),
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: _mediaSize.height * 0.05),
          width: _mediaSize.height * 0.25,
          height: _mediaSize.height * 1,
          child: Column(
            children: [
              SizedBox(height: _mediaSize.height * 0.02),
              _BtnMenu(
                route: '/RegistroTemps',
                title: 'Registro De Temperaturas',
              ),
              SizedBox(height: _mediaSize.height * 0.02),
              _BtnMenu(
                route: '/MovimientosPage',
                title: 'Movimientos y Capturas',
              ),
              SizedBox(height: _mediaSize.height * 0.02),
              _BtnMenu(
                title: 'Temperaturas Desequilibrio',
                route: '/DesequilibriosPage',
              ),
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
      //to navigate to another page when the button is clicked the route is sent by parameters of the class
      onTap: () {
        Navigator.pushNamed(context, route!);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
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
                      maxLines: 3,
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

class ContenedorCentro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final _mediasize = MediaQuery.of(context).size;
    return Opacity(
      opacity: 0.7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: Container(
          height: _mediasize.height * 0.7,
          width: _mediasize.width * 0.84,
          color: Colors.white,
        ),
      ),
    );
  }
}
