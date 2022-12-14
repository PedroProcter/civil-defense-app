import 'package:civil_defense_app/pages/public/forget_password.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              _userTextField(),
              SizedBox(
                height: 15,
              ),
              _passwordTextField(),
              SizedBox(
                height: 20,
              ),
              _bottonLogin(),
              SizedBox(
                height: 20,
              ),
              _forget_password()
            ],
          ),
        ),
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electronico'),
          onChanged: ((value) {}),
        ),
      );
    });
  }

  Widget _passwordTextField() {
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
              labelText: 'Password'),
          onChanged: ((value) {}),
        ),
      );
    });
  }

  Widget _bottonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return TextButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Iniciar Sesion',
              style: TextStyle(color: Color(0xFFFEFEFF))),
          color: Color(0xfffd6c00),
        ),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        },
      );
    });
  }

  Widget _forget_password() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return TextButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Recuperar conseña',
              style: TextStyle(color: Color(0xFFFEFEFF))),
          color: Color(0xfffd6c00),
        ),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ForgetPassword()));
        },
      );
    });
  }
}
