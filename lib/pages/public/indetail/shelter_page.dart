import 'package:flutter/material.dart';

class ShelterPage extends StatelessWidget {
  final String city;
  final String code;
  final String building;
  final String coordinator;
  final String phoneNumber;
  final String capacity;
  final String lat;
  final String lon;

  const ShelterPage({
    super.key,
    required this.city,
    required this.code,
    required this.building,
    required this.coordinator,
    required this.phoneNumber,
    required this.capacity,
    required this.lat,
    required this.lon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Text(city),
            Text(code),
            Text(building),
            Text(coordinator),
            Text(phoneNumber),
            Text(capacity),
            Text(lat),
            Text(lon),
          ],
        ),
      ),
    );
  }
}
