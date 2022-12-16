import 'package:civil_defense_app/models/situation.dart';
import 'package:civil_defense_app/pages/public/home.dart';
import 'package:civil_defense_app/pages/public/indetail/situation_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:civil_defense_app/models/shelter.dart';

import 'indetail/shelter_page.dart';

Future<http.Response> getMySituations(String token) {
  String url = 'https://adamix.net/defensa_civil/def/situaciones.php';
  Uri uri = Uri.parse(url);

  return http.post(uri, body: {'token': token});
}

List jsonToMySituations(String json) {
  List output = [];

  dynamic jsonDecoded = jsonDecode(json);
  for (int i = 0; i < jsonDecoded['datos'].length; i++) {
    output.add(Situation.fromJson(jsonDecoded['datos'][i]));
  }

  return output;
}

class SituationsMap extends StatelessWidget {
  final List mySituations;

  const SituationsMap({
    super.key,
    required this.mySituations,
  });

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = <Marker>[];

    for (int index = 0; index < mySituations.length; index++) {
      Situation situation = mySituations[index];
      markers.add(
        Marker(
          width: 40,
          height: 40,
          point:
              LatLng(double.parse(situation.lat), double.parse(situation.lon)),
          builder: (context) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SituationPage(
                      title: situation.title,
                      description: situation.description,
                      date: situation.date,
                      photoBase64: situation.photoBase64,
                      status: situation.status,
                      lat: situation.lat,
                      lon: situation.lon,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.home)),
        ),
      );
    }

    return Column(
      children: [
        Flexible(
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(18.483402, -69.929611),
              zoom: 5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(markers: markers),
            ],
          ),
        ),
      ],
    );
  }
}

class SituationsMapPage extends StatelessWidget {
  final String token;
  const SituationsMapPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            AppBar(title: Text('Mapas'), backgroundColor: Color(0xfffd6c00)),
        drawer: appDrawer(token: token),
        body: FutureBuilder(
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              } else if (snapshot.hasData) {
                final data = snapshot.data?.body;
                return SituationsMap(mySituations: jsonToMySituations('$data'));
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          future: getMySituations(token),
        ),
      ),
    );
  }
}
