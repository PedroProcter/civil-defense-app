import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class SituationPage extends StatelessWidget {
  final String photoBase64;
  final String title;
  final String description;
  final String status;
  final String date;
  final String lat;
  final String lon;

  const SituationPage({
    super.key,
    required this.photoBase64,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.lat,
    required this.lon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('situation'),
          backgroundColor: Color(0xfffd6c00),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ListView(
              children: [
                //Text(photoBase64),
                SizedBox(height: 5),
                Text('Titutlo: ' + title),
                SizedBox(height: 5),
                Text('Descripcion: ' + description,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text('Estado: ' + status),
                SizedBox(height: 5),
                Text('Fecha: ' + date),
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
