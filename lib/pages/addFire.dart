

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class AddFire extends StatefulWidget {
 
  const AddFire();
  @override
  _AddFireState createState() => _AddFireState();
}

class _AddFireState extends State<AddFire> {
  
  String imagen;
  DateTime _fecha;

  File _imagenSeleccionada;
  String _opcionSeleccionadaSeveridad = 'Baja';
  String _opcionSeleccionadaCanton = 'Cañas';
  String _opcionSeleccionadaDistrito = 'Liberia';

  List<String> _distritos = ['Liberia', 'CañasDulces', 'Nacascolo'];

  List<String> _severidad = ['Baja', 'Media', 'Alta'];

  List<String> _cantones = ['Cañas', 'Abangares', 'Santa Cruz'];

  @override
  Widget build(BuildContext context) {
   
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
            _crearCantones(),
            Divider(),
           _crearDistrito(),
            Divider(),
           _crearSeveridad(),
            Divider(),
           _crearFecha(context),
           Divider(),
            _crearImagen(),
            Divider(),
            Container(),
            if (_imagenSeleccionada != null)
              SizedBox(
                height: 180,
                child: Image.file(_imagenSeleccionada),
              ),
            Divider(),
            CupertinoButton.filled(
              child: Text("Añadir incendio"),
              onPressed: () {},
            ),
            
          ],
        ),
      ),
    );
  }

//dropdownDistrito
  List<DropdownMenuItem<String>> getOpcionesDistrito() {
    List<DropdownMenuItem<String>> lista = new List();

    _distritos.forEach((distrito) {
      lista.add(DropdownMenuItem(
        child: Text(distrito),
        value: distrito,
      ));
    });

    return lista;
  }
  
  Widget _crearDistrito() {

    return Row(
      children: <Widget>[

        Icon(Icons.edit_location),
            SizedBox(width: 30.0),
            Expanded(
              child: DropdownButton(
                value: _opcionSeleccionadaDistrito,
                items: getOpcionesDistrito(),
                onChanged: (opt) {
                  setState(() {
                    _opcionSeleccionadaDistrito = opt;
                  });
                 /* incendioProvider.changeDistrito(opt);*/
                
                },
              ),
            ),
      ],
    );

  }

//dropdownCantones
 List<DropdownMenuItem<String>> getOpcionesCantones() {
    List<DropdownMenuItem<String>> lista = new List();

    _cantones.forEach((canton) {
      lista.add(DropdownMenuItem(
        child: Text(canton),
        value: canton,
      ));
    });

    return lista;
  }
 Widget _crearCantones() {

    return Row(
      children: <Widget>[

      Icon(Icons.edit_location),
            SizedBox(width: 30.0),
            Expanded(
              child: DropdownButton(
                value: _opcionSeleccionadaCanton,
                items: getOpcionesCantones(),
                onChanged: (opt) {
                  setState(() {
                    _opcionSeleccionadaCanton = opt;
                  });
               /*   incendioProvider.changeCanton(opt);*/
                   
                },
              ),
            ),
      ],
    );

  }
  //dropdownSeveridad
    List<DropdownMenuItem<String>> getOpcionesSeveridad() {
    List<DropdownMenuItem<String>> lista = new List();

    _severidad.forEach((severidad) {
      lista.add(DropdownMenuItem(
        child: Text(severidad),
        value: severidad,
      ));
    });

    return lista;
  }
   Widget _crearSeveridad() {

    return Row(
      children: <Widget>[

      Icon(Icons.whatshot),
            SizedBox(width: 30.0),
            
            Expanded(
              child: DropdownButton(
                value: _opcionSeleccionadaSeveridad,
                items: getOpcionesSeveridad(),
                onChanged: (opt) {
                  setState(() {
                    _opcionSeleccionadaSeveridad = opt;
                  });
                
                /*  incendioProvider.changeSeveridad(opt);*/
                },
              ),
            ),
      ],
    );

  }


  Widget _crearFecha( BuildContext context ) {
    _fecha=DateTime.now();
    var newFormat = DateFormat("dd-MM-yy");
    String updatedDt = newFormat.format(_fecha);
    print(updatedDt); // 20-04-03
    return TextField(
      enableInteractiveSelection: false,
    
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Fecha',
        labelText: updatedDt,
        icon: Icon( Icons.calendar_today )
      ),
     
    );

  }
 
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
