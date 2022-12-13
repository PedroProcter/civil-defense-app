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
        body: ListView(
          children: [
            Text(title),
            Image(image: NetworkImage(photoUrl)),
            Text(description),
          ],
        ),
      ),
    );
  }
}
