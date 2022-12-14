import 'package:flutter/material.dart';

class PreventiveMeasurementPage extends StatelessWidget {
  final String title;
  final String photoUrl;
  final String description;

  const PreventiveMeasurementPage(
      {super.key,
      required this.title,
      required this.photoUrl,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Medidas Preventivas'),
          backgroundColor: Color(0xfffd6c00),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: ListView(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Image(
                  image: NetworkImage(photoUrl),
                  height: 200,
                ),
                SizedBox(height: 20),
                Text(description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
