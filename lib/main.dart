import 'package:civil_defense_app/pages/public/history_page.dart';
import 'package:civil_defense_app/pages/public/members_page.dart';
import 'package:civil_defense_app/pages/public/news_page.dart';
import 'package:civil_defense_app/pages/public/preventive_measures_page.dart';
import 'package:civil_defense_app/pages/public/services_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PreventiveMeasuresPage(),
    );
  }
}
