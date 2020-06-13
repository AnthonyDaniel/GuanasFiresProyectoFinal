import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guanasfires/pages/map_add_fire.dart';
import 'package:guanasfires/services/auth_services/sign_in.dart';
import 'package:guanasfires/theme/colors/light_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddFire extends StatefulWidget {
  const AddFire();
  @override
  _AddFireState createState() => _AddFireState();
}

class _AddFireState extends State<AddFire> {

  String _imagen;
  DateTime _fecha;

  File _imagenSeleccionada;
  String _opcionSeleccionadaSeveridad;
  String _opcionSeleccionadaCanton;
  String _opcionSeleccionadaDistrito;

  int _severidad = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightWhite,
      body: new Column(
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.location_searching),
            title: Text('Tu ubicación actual',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0
                )
            ),
            subtitle: Column(
              children: <Widget>[
                Container(
                  height: 120,//MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Map()
                ),
                Text('En esta ubicación se reportara el incendio (*)',
                  style: new TextStyle(
                      fontSize: 9.0
                  )
                ),
              ],
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.location_on),
            title:  Text('Selecciona el cantón',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0
                )
            ),
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
            title:  Text('Selecciona el distrito',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0
                )
            ),
            subtitle:  DropdownButton(
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
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
              )
            ),
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
                  style: new TextStyle(
                      fontSize: 11.0),
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
                  style: new TextStyle(
                      fontSize: 11.0),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1.0,
          ),
        ],
      ),
    );
  }

//dropdownCantones.dart
  List<DropdownMenuItem<String>> getOpcionesCantones() {
    List<DropdownMenuItem<String>> lista = new List();
    cantones.forEach((element) {
      if(element.codProvi == "5") {
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
      if(element.descripcion == _opcionSeleccionadaCanton){
        codCanton =  element.codigo;
      }
    });
    distritos.forEach((distrito) {
      if(distrito.codProvi == "5" && distrito.codCant == codCanton){
        lista.add(DropdownMenuItem(
          child: Text(distrito.descripcion),
          value: distrito.descripcion,
        ));
      }
    });
    return lista;
  }
  //dropdownSeveridad
  Widget _crearImagen() {
    return IconButton(
        icon: Icon(Icons.camera_alt),
        color: Colors.grey,
        onPressed: () async {
          var image = await ImagePicker.pickImage(source: ImageSource.gallery);
          setState(() {
            _imagenSeleccionada = image;
          });
        });
  }
}



