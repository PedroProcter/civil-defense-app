import 'package:civil_defense_app/pages/public/home.dart';
import 'package:civil_defense_app/pages/public/login.dart';
import 'package:civil_defense_app/pages/public/slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proyecto Final',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SliderPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFEFF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('Defensa civil',
                style: TextStyle(
                    fontSize: 30,
                    color: Color(0xfffd6c00),
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
            ),
            const CircularProgressIndicator(
              color: Color(0xfffd6c00),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 15,
            ),
            Image.asset('assets/images/defensa_civil_logo.png')
          ]),
        ),
      ),
    );
  }
}
