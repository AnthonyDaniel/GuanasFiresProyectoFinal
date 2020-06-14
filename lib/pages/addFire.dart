import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guanasfires/services/auth_services/sign_in.dart';
import 'package:guanasfires/theme/colors/light_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class AddFire extends StatefulWidget {
  const AddFire();
  @override
  _AddFireState createState() => _AddFireState();
}

class _AddFireState extends State<AddFire> {
  File _image = null;
  String _uploadedFileURL;

  String _opcionSeleccionadaCanton;
  String _opcionSeleccionadaDistrito;

  int _severidad = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightWhite,
      body: new Column(
        children: <Widget>[
          /*
          new ListTile(
            leading: const Icon(Icons.location_searching),
            title: Text('Tu ubicación actual',
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            subtitle: Column(
              children: <Widget>[
                Container(
                    height: 120, //MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Map()),
                Text('En esta ubicación se reportara el incendio (*)',
                    style: new TextStyle(fontSize: 9.0)),
              ],
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.location_on),
            title: Text('Selecciona el cantón',
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            subtitle: new DropdownButton(
              value: _opcionSeleccionadaCanton,
              items: getOpcionesCantones(),
              onChanged: (opt) {
                setState(() {
                  _opcionSeleccionadaCanton = opt;
                  _opcionSeleccionadaDistrito = null;
                });
              },
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.location_on),
            title: Text('Selecciona el distrito',
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            subtitle: DropdownButton(
              value: _opcionSeleccionadaDistrito,
              items: getOpcionesDistrito(),
              onChanged: (opt) {
                setState(() {
                  _opcionSeleccionadaDistrito = opt;
                });
              },
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.info),
            title: Text('Seleciona la severidad',
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            subtitle: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Radio(
                  value: 0,
                  groupValue: _severidad,
                  onChanged: null,
                ),
                new Text(
                  'Baja',
                  style: new TextStyle(fontSize: 11.0),
                ),
                new Radio(
                  value: 1,
                  groupValue: _severidad,
                  onChanged: null,
                ),
                new Text(
                  'Media',
                  style: new TextStyle(
                    fontSize: 11.0,
                  ),
                ),
                new Radio(
                  value: 2,
                  groupValue: _severidad,
                  onChanged: null,
                ),
                new Text(
                  'Alta',
                  style: new TextStyle(fontSize: 11.0),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1.0,
          ),
          */
          Text('Selected Image'),
          _image != null
              ? Image.asset(
                  _image.path,
                  height: 150,
                )
              : Container(height: 150),
          _image == null
              ? RaisedButton(
                  child: Text('Choose File'),
                  onPressed: chooseFile,
                  color: Colors.cyan,
                )
              : Container(),
          _image != null
              ? RaisedButton(
                  child: Text('Upload File'),
                  onPressed: uploadFile,
                  color: Colors.cyan,
                )
              : Container(),
          _image != null
              ? RaisedButton(
                  child: Text('Clear Selection'),
                  onPressed: null,
                )
              : Container(),
          Text('Uploaded Image'),
          _uploadedFileURL != null
              ? Image.network(
                  _uploadedFileURL,
                  height: 150,
                )
              : Container(),
        ],
      ),
    );
  }

//dropdownCantones.dart
  List<DropdownMenuItem<String>> getOpcionesCantones() {
    List<DropdownMenuItem<String>> lista = new List();
    cantones.forEach((element) {
      if (element.codProvi == "5") {
        lista.add(DropdownMenuItem(
          child: Text(element.descripcion),
          value: element.descripcion,
        ));
      }
    });
    return lista;
  }

//dropdownDistrito
  List<DropdownMenuItem<String>> getOpcionesDistrito() {
    List<DropdownMenuItem<String>> lista = new List();

    String codCanton;

    cantones.forEach((element) {
      if (element.descripcion == _opcionSeleccionadaCanton) {
        codCanton = element.codigo;
      }
    });
    distritos.forEach((distrito) {
      if (distrito.codProvi == "5" && distrito.codCant == codCanton) {
        lista.add(DropdownMenuItem(
          child: Text(distrito.descripcion),
          value: distrito.descripcion,
        ));
      }
    });
    return lista;
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }
}
