import 'dart:convert';

import 'package:civil_defense_app/pages/public/home.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          Text(date, style: TextStyle(fontSize: 13)),
          SizedBox(height: 15),
          Image(
            image: NetworkImage(photoUrl),
            height: 200,
          ),
          SizedBox(height: 15),
          Text(content),
        ],
      ),
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
        appBar: AppBar(
          title: Text('Noticias'),
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

class AuthNewsPage extends StatelessWidget {
  final String token;
  const AuthNewsPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Noticias'),
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
