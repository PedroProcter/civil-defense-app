import 'dart:convert';

import 'package:civil_defense_app/models/member.dart';
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
    return Column(
      children: [
        Text(name),
        Text(position),
        Image(image: NetworkImage(photoUrl)),
      ],
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
