import 'package:civil_defense_app/pages/public/about_us_page.dart';
import 'package:civil_defense_app/pages/public/members_page.dart';
import 'package:civil_defense_app/pages/public/news_page.dart';
import 'package:civil_defense_app/pages/public/preventive_measures_page.dart';
import 'package:civil_defense_app/pages/public/shelters_page.dart';
import 'package:civil_defense_app/pages/public/videos_page.dart';
import 'package:civil_defense_app/pages/public/volunteer.dart';
import 'package:flutter/material.dart';

import 'history.dart';
import 'shelters_map_page.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Color(0xfffd6c00),
        ),
        drawer: appDrawer(),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Defensa Civil',
                style: TextStyle(
                    fontSize: 30,
                    color: Color(0xfffd6c00),
                    fontWeight: FontWeight.bold)),
            Text('Republica Dominicana',
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff5284b8),
                    fontWeight: FontWeight.bold)),
          ]),
        ));
  }
}

class appDrawer extends StatelessWidget {
  const appDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xffD06224),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                child: Image.asset(
                  'assets/images/defensa_civil_logo.png',
                  width: 200,
                ),
              ),
            ),
            SizedBox(
              child: InkWell(
                child: Container(
                  margin: const EdgeInsets.only(top: 0),
                  padding: const EdgeInsets.only(left: 15),
                  width: double.infinity,
                  child: const Text('Noticias'),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewsPage()));
                },
              ),
            ),
            SizedBox(
              child: InkWell(
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.only(left: 15),
                  width: double.infinity,
                  child: const Text('Historia'),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HistoryPage()));
                },
              ),
            ),
            SizedBox(
              child: InkWell(
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.only(left: 15),
                  width: double.infinity,
                  child: const Text('Medidas Preventivas'),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreventiveMeasuresPage()));
                },
              ),
            ),
            SizedBox(
              child: InkWell(
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.only(left: 15),
                  width: double.infinity,
                  child: const Text('Miembros'),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MembersPage()));
                },
              ),
            ),
            SizedBox(
              child: InkWell(
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.only(left: 15),
                  width: double.infinity,
                  child: const Text('Albergues'),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SheltersPage()));
                },
              ),
            ),
            SizedBox(
              child: InkWell(
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.only(left: 15),
                  width: double.infinity,
                  child: const Text('Mapas'),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SheltersMapPage()));
                },
              ),
            ),
            SizedBox(
              child: InkWell(
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.only(left: 15),
                  width: double.infinity,
                  child: const Text('Videos'),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VideosPage()));
                },
              ),
            ),
            SizedBox(
              child: InkWell(
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.only(left: 15),
                  width: double.infinity,
                  child: const Text('Quiero ser voluntario'),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VolunteerPage()));
                },
              ),
            ),
            SizedBox(
              child: InkWell(
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.only(left: 15),
                  width: double.infinity,
                  child: const Text('Sobre nosotros'),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUsPage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
