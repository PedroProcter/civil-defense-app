import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class VolunteerPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  String id = '';
  String name = '';
  String lastname = '';
  String email = '';
  String password = '';
  String telephone = '';

  Map<String, dynamic> volunteerToJson() {
    Map<String, dynamic> output = {
      'cedula': id,
      'nombre': name,
      'apellido': lastname,
      'correo': email,
      'telefono': telephone,
      'clave': password,
    };

    return output;
  }

  Future<http.Response> sendPost(Map<String, dynamic> json) {
    return http.post(
      Uri.parse('https://adamix.net/defensa_civil/def/registro.php'),
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
        appBar: AppBar(
            title: const Text('Quiero ser voluntario'),
            backgroundColor: const Color(0xfffd6c00)),
        drawer: DrawerWithoutLogin(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _IDTextField(),
              const SizedBox(
                height: 15,
              ),
              _nameTextField(),
              const SizedBox(
                height: 20,
              ),
              _lastnameTextField(),
              const SizedBox(
                height: 20,
              ),
              _emailTextField(),
              const SizedBox(
                height: 20,
              ),
              _passwordTextField(),
              const SizedBox(
                height: 20,
              ),
              _phoneTextField(),
              const SizedBox(
                height: 20,
              ),
              _setData(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _IDTextField() {
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

  Widget _nameTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
              icon: Icon(Icons.people_alt_outlined),
              hintText: 'Nombre',
              labelText: 'Nombre'),
          onChanged: ((value) {
            name = value;
          }),
        ),
      );
    });
  }

  Widget _lastnameTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
              icon: Icon(Icons.people_alt_outlined),
              hintText: 'Apellido',
              labelText: 'Apellido'),
          onChanged: ((value) {
            lastname = value;
          }),
        ),
      );
    });
  }

  Widget _emailTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electronico'),
          onChanged: ((value) {
            email = value;
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

  Widget _phoneTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
              icon: Icon(Icons.phone),
              hintText: '000-000-0000',
              labelText: 'Telefono'),
          onChanged: ((value) {
            telephone = value;
          }),
        ),
      );
    });
  }

  Widget _setData() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return TextButton(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          color: const Color(0xfffd6c00),
          child:
              const Text('Enviar', style: TextStyle(color: Color(0xFFFEFEFF))),
        ),
        onPressed: () async {
          http.Response response = await sendPost(volunteerToJson());
          dynamic json = jsonDecode(response.body);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(json['mensaje'])));
        },
      );
    });
  }
}
