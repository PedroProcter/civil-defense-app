import 'dart:convert';

import 'package:civil_defense_app/models/shelter.dart';
import 'package:civil_defense_app/pages/public/indetail/shelter_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class CivilDefenseShelterTile extends StatelessWidget {
  final String city;
  final String code;
  final String building;
  final String coordinator;
  final String phoneNumber;
  final String capacity;
  final String lat;
  final String lon;

  const CivilDefenseShelterTile({
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => ShelterPage(
              city: city,
              code: code,
              building: building,
              coordinator: coordinator,
              phoneNumber: phoneNumber,
              capacity: capacity,
              lat: lat,
              lon: lon,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Text(city),
          Text(code),
          Text(building),
          Text(coordinator),
          Text(phoneNumber),
          Text(capacity),
          Text(lat),
          Text(lon),
        ],
      ),
    );
  }
}

class CivilDefenseSheltersList extends StatelessWidget {
  final List civilDefenseShelters;

  const CivilDefenseSheltersList(
      {super.key, required this.civilDefenseShelters});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: civilDefenseShelters.length,
      itemBuilder: (BuildContext context, int index) {
        Shelter shelter = civilDefenseShelters[index];
        return CivilDefenseShelterTile(
          city: shelter.city,
          code: shelter.code,
          building: shelter.building,
          coordinator: shelter.coordinator,
          phoneNumber: shelter.phoneNumber,
          capacity: shelter.capacity,
          lat: shelter.lat,
          lon: shelter.lon,
        );
      },
    );
  }
}

class SheltersPage extends StatelessWidget {
  const SheltersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                return CivilDefenseSheltersList(
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
