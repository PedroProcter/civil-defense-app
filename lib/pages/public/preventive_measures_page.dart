import 'dart:convert';

import 'package:civil_defense_app/models/preventive_measurement.dart';
import 'package:civil_defense_app/pages/public/home.dart';
import 'package:civil_defense_app/pages/public/indetail/preventive_measurement_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getCivilDefensePreventiveMeasures() {
  String url = 'https://adamix.net/defensa_civil/def/medidas_preventivas.php';
  Uri uri = Uri.parse(url);

  return http.get(uri);
}

List jsonToCivilDefensePreventiveMeasures(String json) {
  List output = [];

  dynamic jsonDecoded = jsonDecode(json);
  for (int i = 0; i < jsonDecoded['datos'].length; i++) {
    output.add(PreventiveMeasurement.fromJson(jsonDecoded['datos'][i]));
  }

  return output;
}

class CivilDefensePreventiveMeasurementTile extends StatelessWidget {
  final String title;
  final String photoUrl;
  final String description;

  const CivilDefensePreventiveMeasurementTile({
    super.key,
    required this.title,
    required this.photoUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => PreventiveMeasurementPage(
              title: title,
              photoUrl: photoUrl,
              description: description,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text(title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Image(
                image: NetworkImage(photoUrl),
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CivilDefensePreventiveMeasuresList extends StatelessWidget {
  final List civilDefensePreventiveMeasures;

  const CivilDefensePreventiveMeasuresList(
      {super.key, required this.civilDefensePreventiveMeasures});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: civilDefensePreventiveMeasures.length,
      itemBuilder: (BuildContext context, int index) {
        PreventiveMeasurement preventiveMeasurement =
            civilDefensePreventiveMeasures[index];
        return CivilDefensePreventiveMeasurementTile(
            title: preventiveMeasurement.title,
            description: preventiveMeasurement.description,
            photoUrl: preventiveMeasurement.photoUrl);
      },
    );
  }
}

class PreventiveMeasuresPage extends StatelessWidget {
  const PreventiveMeasuresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Medidas Preventivas'),
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
                return CivilDefensePreventiveMeasuresList(
                    civilDefensePreventiveMeasures:
                        jsonToCivilDefensePreventiveMeasures('$data'));
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          future: getCivilDefensePreventiveMeasures(),
        ),
      ),
    );
  }
}
