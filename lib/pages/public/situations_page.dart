import 'dart:convert';

import 'package:civil_defense_app/models/shelter.dart';
import 'package:civil_defense_app/models/situation.dart';
import 'package:civil_defense_app/pages/public/home.dart';
import 'package:civil_defense_app/pages/public/indetail/shelter_page.dart';
import 'package:civil_defense_app/pages/public/indetail/situation_page.dart';
import 'package:civil_defense_app/pages/public/situations_map_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getMySituations(String token) {
  String url = 'https://adamix.net/defensa_civil/def/situaciones.php';
  Uri uri = Uri.parse(url);

  return http.post(uri, body: {'token': token});
}

List jsonToMygetMySituations(String json) {
  List output = [];

  dynamic jsonDecoded = jsonDecode(json);
  for (int i = 0; i < jsonDecoded['datos'].length; i++) {
    output.add(Situation.fromJson(jsonDecoded['datos'][i]));
  }

  return output;
}

class SituationTile extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String photoBase64;
  final String status;
  final String date;
  final String lat;
  final String lon;

  const SituationTile({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.photoBase64,
    required this.status,
    required this.date,
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
            builder: (BuildContext context) => SituationPage(
              title: title,
              description: description,
              photoBase64: photoBase64,
              status: status,
              date: date,
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
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                // Text(
                //   photoBase64,
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                //   textAlign: TextAlign.center,
                // ),
                Text(
                  status,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Text(
                  date,
                  style: TextStyle(fontSize: 20),
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

class SituationsList extends StatefulWidget {
  final List civilDefenseShelters;

  const SituationsList({super.key, required this.civilDefenseShelters});

  @override
  State<SituationsList> createState() => _SituationsListState();
}

class _SituationsListState extends State<SituationsList> {
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
                  Situation situation = filterShelters[index];
                  return SituationTile(
                    id: situation.id,
                    title: situation.title,
                    description: situation.description,
                    photoBase64: situation.photoBase64,
                    status: situation.status,
                    date: situation.date,
                    lat: situation.lat,
                    lon: situation.lon,
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

class SituationsPage extends StatelessWidget {
  final String token;
  const SituationsPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Situaciones'),
          backgroundColor: Color(0xfffd6c00),
        ),
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
                return SituationsList(
                    civilDefenseShelters: jsonToMySituations('$data'));
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
