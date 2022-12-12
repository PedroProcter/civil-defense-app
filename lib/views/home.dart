import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
          backgroundColor: Color(0xfffd6c00),
        ),
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
