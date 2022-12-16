import 'dart:convert';

import 'package:civil_defense_app/pages/public/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:civil_defense_app/models/civil_defense_service.dart';

Future<http.Response> getCivilDefenseServices() {
  String url = 'https://adamix.net/defensa_civil/def/servicios.php';
  Uri uri = Uri.parse(url);

  return http.get(uri);
}

List jsonToCivilDefenseServices(String json) {
  List output = [];

  dynamic jsonDecoded = jsonDecode(json);
  for (int i = 0; i < jsonDecoded['datos'].length; i++) {
    output.add(CivilDefenseService.fromJson(jsonDecoded['datos'][i]));
  }

  return output;
}

class CivilDefenseServiceTile extends StatelessWidget {
  final String name;
  final String description;
  final String photoUrl;

  const CivilDefenseServiceTile(
      {super.key,
      required this.name,
      required this.description,
      required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name),
        Image(image: NetworkImage(photoUrl)),
        Text(description),
      ],
    );
  }
}

class CivilDefenseServiceList extends StatelessWidget {
  final List civilDefenseServices;

  const CivilDefenseServiceList(
      {super.key, required this.civilDefenseServices});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: civilDefenseServices.length,
      itemBuilder: (BuildContext context, int index) {
        CivilDefenseService civilDefenseService = civilDefenseServices[index];
        return CivilDefenseServiceTile(
            name: civilDefenseService.name,
            description: civilDefenseService.description,
            photoUrl: civilDefenseService.photoUrl);
      },
    );
  }
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                return CivilDefenseServiceList(
                    civilDefenseServices: jsonToCivilDefenseServices('$data'));
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          future: getCivilDefenseServices(),
        ),
      ),
    );
  }
}
