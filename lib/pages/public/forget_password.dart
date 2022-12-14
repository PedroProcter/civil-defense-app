import 'package:civil_defense_app/pages/public/login.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class ForgetPassword extends StatefulWidget {
  static String id = 'login_page';

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/defensa_civil_logo.png',
              ),
              SizedBox(height: 15.0),
              _lasstest_passwordTextField(),
              SizedBox(
                height: 15,
              ),
              _new_passwordTextField(),
              SizedBox(
                height: 40,
              ),
              _setData()
            ],
          ),
        ),
      ),
    );
  }

  Widget _lasstest_passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Password',
              labelText: 'Ultima contraseña'),
          onChanged: ((value) {}),
        ),
      );
    });
  }

  Widget _new_passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Password',
              labelText: 'Nueva Contraseña'),
          onChanged: ((value) {}),
        ),
      );
    });
  }

  Widget _setData() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return TextButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child:
              Text('Enviar datos', style: TextStyle(color: Color(0xFFFEFEFF))),
          color: Color(0xfffd6c00),
        ),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
      );
    });
  }
}
