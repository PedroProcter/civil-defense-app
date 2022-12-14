import 'package:flutter/material.dart';

import 'home.dart';

class VolunteerPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  _VolunteerPageState createState() => _VolunteerPageState();
}

class _VolunteerPageState extends State<VolunteerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text('Quiero ser voluntario'),
            backgroundColor: Color(0xfffd6c00)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _IDTextField(),
              SizedBox(
                height: 15,
              ),
              _nameTextField(),
              SizedBox(
                height: 20,
              ),
              _lastnameTextField(),
              SizedBox(
                height: 20,
              ),
              _emailTextField(),
              SizedBox(
                height: 20,
              ),
              _passwordTextField(),
              SizedBox(
                height: 20,
              ),
              _phoneTextField(),
              SizedBox(
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
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              icon: Icon(Icons.perm_identity),
              hintText: '000-0000000-0',
              labelText: 'Cedula'),
          onChanged: ((value) {}),
        ),
      );
    });
  }

  Widget _nameTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              icon: Icon(Icons.people_alt_outlined),
              hintText: 'Nombre',
              labelText: 'Nombre'),
          onChanged: ((value) {}),
        ),
      );
    });
  }

  Widget _lastnameTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              icon: Icon(Icons.people_alt_outlined),
              hintText: 'Apellido',
              labelText: 'Apellido'),
          onChanged: ((value) {}),
        ),
      );
    });
  }

  Widget _emailTextField() {
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

  Widget _phoneTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              icon: Icon(Icons.phone),
              hintText: '000-000-0000',
              labelText: 'Telefono'),
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
          child: Text('Enviar', style: TextStyle(color: Color(0xFFFEFEFF))),
          color: Color(0xfffd6c00),
        ),
        onPressed: () {},
      );
    });
  }
}
