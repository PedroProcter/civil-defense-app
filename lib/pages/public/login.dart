import 'dart:convert';

import 'package:civil_defense_app/pages/public/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String id = '';
  String password = '';
  String token = '';

  Map<String, dynamic> volunteerToJson() {
    Map<String, dynamic> output = {
      'cedula': id,
      'clave': password,
    };

    return output;
  }

  Future<http.Response> sendPost(Map<String, dynamic> json) {
    return http.post(
      Uri.parse('https://adamix.net/defensa_civil/def/iniciar_sesion.php'),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: json,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/defensa_civil_logo.png',
              ),
              const SizedBox(height: 15.0),
              _userTextField(),
              const SizedBox(
                height: 15,
              ),
              _passwordTextField(),
              const SizedBox(
                height: 20,
              ),
              _bottonLogin(),
              const SizedBox(
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              icon: Icon(Icons.perm_identity),
              hintText: '000-0000000-0',
              labelText: 'Cedula'),
          onChanged: ((value) {
            id = value;
          }),
        ),
      );
    });
  }

  Widget _passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'Password',
              labelText: 'Password'),
          onChanged: ((value) {
            password = value;
          }),
        ),
      );
    });
  }

  Widget _bottonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return TextButton(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          color: const Color(0xfffd6c00),
          child: const Text('Iniciar Sesion',
              style: TextStyle(color: Color(0xFFFEFEFF))),
        ),
        onPressed: () async {
          http.Response response = await sendPost(volunteerToJson());
          dynamic json = jsonDecode(response.body);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(json['mensaje'])));
          if (json['exito']) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AuthHome(token: json['datos']['token'])));
          }
        },
      );
    });
  }

  Widget _forget_password() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return TextButton(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          color: const Color(0xfffd6c00),
          child: const Text('Recuperar conseña',
              style: TextStyle(color: Color(0xFFFEFEFF))),
        ),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ForgetPassword(token: token)));
        },
      );
    });
  }
}
