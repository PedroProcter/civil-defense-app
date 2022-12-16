import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class ReportSituationPage extends StatefulWidget {
  static String id = 'login_page';
  final String token;

  const ReportSituationPage({super.key, required this.token});

  @override
  _ReportSituationPageState createState() => _ReportSituationPageState();
}

class _ReportSituationPageState extends State<ReportSituationPage> {
  String selectedImagePath = '';

  String title = '';
  String description = '';
  String latitud = '';
  String longitud = '';

  Map<String, dynamic> situationToJson() {
    Map<String, dynamic> output = {
      'cedula': title,
      'nombre': description,
      'apellido': latitud,
      'correo': longitud,
    };

    return output;
  }

  Future sendPost() async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://adamix.net/defensa_civil/def/nueva_situacion.php'));
    request.fields['titulo'] = title;
    request.fields['descripcion'] = description;
    request.fields['latitud'] = latitud;
    request.fields['longitud'] = longitud;
    request.fields['token'] = widget.token;
    request.fields['foto'] = base64Image;
    // request.files
    //     .add(await http.MultipartFile.fromPath('foto', '${image?.path}'));
    return await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text('Reportar situación'),
            backgroundColor: Color(0xfffd6c00)),
        drawer: appDrawer(
          token: widget.token,
        ),
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
              '${image?.path}' == 'null'
                  ? Image.asset(
                      'assets/images/defensa_civil_logo.png',
                      height: 200,
                      width: 200,
                      fit: BoxFit.fill,
                    )
                  : Image.file(
                      File('${image?.path}'),
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

  File? image;
  String base64Image = '';
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      base64Image = base64Encode(await image.readAsBytes());
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future takeImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
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
                            await pickImage();
                            // print('Image_Path:-');
                            // print(selectedImagePath);
                            // if (selectedImagePath != '') {
                            //   Navigator.pop(context);
                            //   setState(() {});
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //           content: Text(
                            //               'No se ha seleccionado una imagen')));
                            // }
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
                            await takeImage();
                            // print('Image_Path:-');
                            // print(selectedImagePath);
                            // if (selectedImagePath != '') {
                            //   Navigator.pop(context);
                            //   setState(() {});
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //           content: Text(
                            //               'No se ha seleccionado una imagen')));
                            // }
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
          onChanged: ((value) {
            title = value;
          }),
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
          onChanged: ((value) {
            description = value;
          }),
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
          onChanged: ((value) {
            latitud = value;
          }),
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
          onChanged: ((value) {
            longitud = value;
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
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text('Enviar', style: TextStyle(color: Color(0xFFFEFEFF))),
          color: Color(0xfffd6c00),
        ),
        onPressed: () async {
          var response = await sendPost();
          print(response.statusCode);
          if (response.statusCode == 200) {
            dynamic json = jsonDecode(await response.stream.bytesToString());
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(json['mensaje'])));
          }
          print(await response.stream.bytesToString());
        },
      );
    });
  }
}
