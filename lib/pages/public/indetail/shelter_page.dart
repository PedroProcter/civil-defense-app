import 'package:flutter/material.dart';

class ShelterPage extends StatelessWidget {
  final String city;
  final String code;
  final String building;
  final String coordinator;
  final String phoneNumber;
  final String capacity;
  final String lat;
  final String lon;

  const ShelterPage({
    super.key,
    required this.city,
    required this.code,
    required this.building,
    required this.coordinator,
    required this.phoneNumber,
    required this.capacity,
    required this.lat,
    required this.lon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(building),
          backgroundColor: Color(0xfffd6c00),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              children: [
                Text('Ciudad: ' + city,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text('Codigo: ' + code),
                SizedBox(height: 5),
                Text('Edificio: ' + building,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text('Coordinador: ' + coordinator),
                SizedBox(height: 5),
                Text('Numero Telefonico: ' + phoneNumber),
                SizedBox(height: 5),
                Text('Capacidad: ' + capacity),
                SizedBox(height: 5),
                Text('Latitud: ' + lat),
                SizedBox(height: 5),
                Text('Longitud: ' + lon),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
