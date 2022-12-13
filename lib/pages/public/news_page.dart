import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:civil_defense_app/models/news.dart';

Future<http.Response> getCivilDefenseNews() {
  String url = 'https://adamix.net/defensa_civil/def/noticias.php';
  Uri uri = Uri.parse(url);

  return http.get(uri);
}

List jsonToCivilDefenseNews(String json) {
  List output = [];

  dynamic jsonDecoded = jsonDecode(json);
  for (int i = 0; i < jsonDecoded['datos'].length; i++) {
    output.add(News.fromJson(jsonDecoded['datos'][i]));
  }

  return output;
}

class CivilDefenseNewsTile extends StatelessWidget {
  final String title;
  final String date;
  final String content;
  final String photoUrl;

  const CivilDefenseNewsTile(
      {super.key,
      required this.title,
      required this.date,
      required this.content,
      required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Text(date),
        Image(image: NetworkImage(photoUrl)),
        Text(content),
      ],
    );
  }
}

class CivilDefenseNewsList extends StatelessWidget {
  final List civilDefenseNews;

  const CivilDefenseNewsList({super.key, required this.civilDefenseNews});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: civilDefenseNews.length,
      itemBuilder: (BuildContext context, int index) {
        News news = civilDefenseNews[index];
        return CivilDefenseNewsTile(
            title: news.title,
            date: news.date,
            content: news.content,
            photoUrl: news.photoUrl);
      },
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

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
                return CivilDefenseNewsList(
                    civilDefenseNews: jsonToCivilDefenseNews('$data'));
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          future: getCivilDefenseNews(),
        ),
      ),
    );
  }
}
