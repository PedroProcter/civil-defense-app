import 'package:civil_defense_app/pages/public/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:civil_defense_app/models/shelter.dart';

import 'indetail/shelter_page.dart';

Future<http.Response> getCivilDefenseShelters() {
  String url = 'https://adamix.net/defensa_civil/def/albergues.php';
  Uri uri = Uri.parse(url);

  return http.get(uri);
}

List jsonToCivilDefenseShelters(String json) {
  List output = [];

  dynamic jsonDecoded = jsonDecode(json);
  for (int i = 0; i < jsonDecoded['datos'].length; i++) {
    output.add(Shelter.fromJson(jsonDecoded['datos'][i]));
  }

  return output;
}

class SheltersMap extends StatelessWidget {
  final List civilDefenseShelters;

  const SheltersMap({
    super.key,
    required this.civilDefenseShelters,
  });

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = <Marker>[];

    for (int index = 0; index < civilDefenseShelters.length; index++) {
      Shelter shelter = civilDefenseShelters[index];
      markers.add(
        Marker(
          width: 40,
          height: 40,
          point: LatLng(double.parse(shelter.lon), double.parse(shelter.lat)),
          builder: (context) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ShelterPage(
                      city: shelter.city,
                      code: shelter.code,
                      building: shelter.building,
                      coordinator: shelter.coordinator,
                      phoneNumber: shelter.phoneNumber,
                      capacity: shelter.capacity,
                      lat: shelter.lat,
                      lon: shelter.lon,
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

class SheltersMapPage extends StatelessWidget {
  const SheltersMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            AppBar(title: Text('Mapas'), backgroundColor: Color(0xfffd6c00)),
        drawer: DrawerWithoutLogin(),
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
                return SheltersMap(
                    civilDefenseShelters: jsonToCivilDefenseShelters('$data'));
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          future: getCivilDefenseShelters(),
        ),
      ),
    );
  }
}
