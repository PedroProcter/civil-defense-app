import 'package:flutter/material.dart';

import 'home.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPage();
}

class _HistoryPage extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Historia',
      home: HistoryHome(),
    );
  }
}

class HistoryHome extends StatelessWidget {
  HistoryHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWithoutLogin(),
        appBar: AppBar(
          title: Text('Historia'),
          backgroundColor: Color(0xffD06224),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child:
                // ignore: prefer_const_literals_to_create_immutables
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Historia',
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xfffd6c00),
                      fontWeight: FontWeight.bold)),
              Text('    de la \nDefensa Civil',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 156, 156, 155),
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 15,
              ),
              Text('''
  Antes del año 1966, cuando llegaba la temporada de huracanes, un grupo de radioaficionados se reunía en la Cruz Roja para estar atentos por si surgía algún tipo de emergencia, inmediatamente ponerse a disposición y ayudar en todo lo posible, inclusive, usando sus propios equipos de comunicación para así tener contacto con el exterior en caso de que las redes telefónicas resultaran afectadas.

  Al surgir el triunvirato fue designado el Dr. Rafael Cantizano Arias, como presidente de la Cruz Roja y al mismo tiempo nombraron al Ing. Carlos D´ Franco como director de la Defensa Civil, quien con un grupo compuesto por seis personas, se instaló en la calle Francia esquina Galván, siendo esa la primera oficina de la Defensa Civil.

  Al surgir el Gobierno Provisional, presidido por el Dr. Héctor García Godoy, a los diecisiete días del mes de junio de 1966, fue promulgada la Ley 257, mediante la cual fue creada la Defensa Civil, institución dependiente de la Secretaría Administrativa de la Presidencia (ahora Ministerio de la Presidencia) y quien en la actualidad preside la Comisión Nacional de Emergencias.

  Más adelante, el local fue trasladado a la calle Dr. Delgado No. 164 y luego en la gestión del Contralmirante Radhamés Lora Salcedo se reubicó a la Plaza de la Salud, donde aún permanece.



''',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 25, 141, 250),
                      fontWeight: FontWeight.bold))
            ]),
          ),
        ));
  }
}
