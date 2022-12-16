import 'dart:convert';

import 'package:civil_defense_app/models/shelter.dart';
import 'package:civil_defense_app/pages/public/home.dart';
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
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  city,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  code,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Text(
                  building,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  coordinator,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Text(
                  phoneNumber,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Text(
                  capacity,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  lat,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Text(
                  lon,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
    );
  }
}

class CivilDefenseSheltersList extends StatefulWidget {
  final List civilDefenseShelters;

  const CivilDefenseSheltersList(
      {super.key, required this.civilDefenseShelters});

  @override
  State<CivilDefenseSheltersList> createState() =>
      _CivilDefenseSheltersListState();
}

class _CivilDefenseSheltersListState extends State<CivilDefenseSheltersList> {
  List filterShelters = [];

  @override
  void initState() {
    filterShelters = widget.civilDefenseShelters.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                filterShelters.clear();
                for (int i = 0; i < widget.civilDefenseShelters.length; i++) {
                  Shelter shelter = widget.civilDefenseShelters[i];
                  if (value.isEmpty) {
                    filterShelters = widget.civilDefenseShelters.toList();
                  } else {
                    if (shelter.city
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                      filterShelters.add(shelter);
                    }
                  }
                }

                setState(() {});
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filterShelters.length,
                itemBuilder: (BuildContext context, int index) {
                  Shelter shelter = filterShelters[index];
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SheltersPage extends StatelessWidget {
  const SheltersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Albergues'),
          backgroundColor: Color(0xfffd6c00),
        ),
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
