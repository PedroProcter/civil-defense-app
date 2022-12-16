import 'dart:convert';

import 'package:civil_defense_app/models/civil_defense_video.dart';
import 'package:civil_defense_app/pages/public/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';

Future<http.Response> getCivilDefenseVideos() {
  String url = 'https://adamix.net/defensa_civil/def/videos.php';
  Uri uri = Uri.parse(url);

  return http.get(uri);
}

List jsonToCivilDefenseVideos(String json) {
  List output = [];

  dynamic jsonDecoded = jsonDecode(json);
  for (int i = 0; i < jsonDecoded['datos'].length; i++) {
    output.add(CivilDefenseVideo.fromJson(jsonDecoded['datos'][i]));
  }

  return output;
}

class CivilDefenseVideoTile extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final String code;

  const CivilDefenseVideoTile({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Text(title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 15.0),
            Text(date, style: TextStyle(fontSize: 15)),
            SizedBox(height: 15.0),
            HtmlWidget(
              '<iframe src="https://www.youtube.com/embed/$code"></iframe>',
              factoryBuilder: () => MyWidgetFactory(),
            ),
            SizedBox(height: 15.0),
            Text(description),
          ],
        ),
      ),
    );
  }
}

class CivilDefenseVideosList extends StatelessWidget {
  final List civilDefenseVideos;

  const CivilDefenseVideosList({super.key, required this.civilDefenseVideos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: civilDefenseVideos.length,
      itemBuilder: (BuildContext context, int index) {
        CivilDefenseVideo video = civilDefenseVideos[index];
        return CivilDefenseVideoTile(
          title: video.title,
          code: video.code,
          description: video.description,
          date: video.date,
        );
      },
    );
  }
}

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Videos'),
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
                return CivilDefenseVideosList(
                    civilDefenseVideos: jsonToCivilDefenseVideos('$data'));
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          future: getCivilDefenseVideos(),
        ),
      ),
    );
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}
