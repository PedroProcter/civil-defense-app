import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'home.dart';

class ReportSituationPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  _ReportSituationPageState createState() => _ReportSituationPageState();
}

class _ReportSituationPageState extends State<ReportSituationPage> {
  String selectedImagePath = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text('Reportar situación'),
            backgroundColor: Color(0xfffd6c00)),
        drawer: DrawerWithoutLogin(),
        body: Center(
          child: Column(
            children: [
              _titleTextField(),
              SizedBox(
                height: 15,
              ),
              _descriptionTextField(),
              _latitudeTextField(),
              SizedBox(
                height: 20,
              ),
              _lengthTextField(),
              SizedBox(
                height: 20,
              ),
              //Declare photo selector
              SizedBox(
                height: 20,
              ),
              selectedImagePath == ''
                  ? Image.asset(
                      'assets/images/defensa_civil_logo.png',
                      height: 200,
                      width: 200,
                      fit: BoxFit.fill,
                    )
                  : Image.file(
                      File(selectedImagePath),
                      height: 200,
                      width: 200,
                      fit: BoxFit.fill,
                    ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Selecciona una imagen',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xfffd6c00))),
                child: Text('Seleccionar'),
                onPressed: () {
                  selectImage();
                  setState(() {});
                },
              ),
              SizedBox(
                height: 30,
              ),
              _setData(),
            ],
          ),
        ),
      ),
    );
  }

// Photo selector
  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 200,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text('Selecciona una imagen desde',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            print('Image_Path:-');
                            print(selectedImagePath);
                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'No se ha seleccionado una imagen')));
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset('assets/images/gallery_icon.png',
                                      height: 60, width: 60),
                                  Text('Galería',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            print('Image_Path:-');
                            print(selectedImagePath);
                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'No se ha seleccionado una imagen')));
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset('assets/images/camara_icon.jpg',
                                      height: 60, width: 60),
                                  Text('Cámara',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

//Photo field functions
  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  Widget _titleTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              icon: Icon(Icons.title), hintText: 'Título', labelText: 'Título'),
          onChanged: ((value) {}),
        ),
      );
    });
  }

  Widget _descriptionTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              icon: Icon(Icons.description),
              hintText: 'Descripción',
              labelText: 'Descripción'),
          onChanged: ((value) {}),
        ),
      );
    });
  }

  Widget _latitudeTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              icon: Icon(Icons.location_city),
              hintText: '00.0000000',
              labelText: 'Latitud'),
          onChanged: ((value) {}),
        ),
      );
    });
  }

  Widget _lengthTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              icon: Icon(Icons.location_city),
              hintText: '00.0000000',
              labelText: 'Longitud'),
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
