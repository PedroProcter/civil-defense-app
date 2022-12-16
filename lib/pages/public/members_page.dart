import 'dart:convert';

import 'package:civil_defense_app/models/member.dart';
import 'package:civil_defense_app/pages/public/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getCivilDefenseMembers() {
  String url = 'https://adamix.net/defensa_civil/def/miembros.php';
  Uri uri = Uri.parse(url);

  return http.get(uri);
}

List jsonToCivilDefenseMembers(String json) {
  List output = [];

  dynamic jsonDecoded = jsonDecode(json);
  for (int i = 0; i < jsonDecoded['datos'].length; i++) {
    output.add(Member.fromJson(jsonDecoded['datos'][i]));
  }

  return output;
}

class CivilDefenseMemberTile extends StatelessWidget {
  final String name;
  final String photoUrl;
  final String position;

  const CivilDefenseMemberTile({
    super.key,
    required this.name,
    required this.photoUrl,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              position,
              style: TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Image(
              image: NetworkImage(photoUrl),
              height: 200,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class CivilDefenseMembersList extends StatelessWidget {
  final List civilDefenseMembers;

  const CivilDefenseMembersList({super.key, required this.civilDefenseMembers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: civilDefenseMembers.length,
      itemBuilder: (BuildContext context, int index) {
        Member member = civilDefenseMembers[index];
        return CivilDefenseMemberTile(
            name: member.name,
            position: member.position,
            photoUrl: member.photoUrl);
      },
    );
  }
}

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Miembros'),
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
                return CivilDefenseMembersList(
                    civilDefenseMembers: jsonToCivilDefenseMembers('$data'));
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          future: getCivilDefenseMembers(),
        ),
      ),
    );
  }
}
