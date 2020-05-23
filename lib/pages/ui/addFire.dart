
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guanasfires/pages/model/incendio.dart';
import 'package:image_picker/image_picker.dart';


class AddFire extends StatefulWidget{
  final Incendio fire;
  AddFire(this.fire);
  @override
  _AddFireState createState() => _AddFireState();

}
final productReference = FirebaseDatabase.instance.reference().child('incendio'); 
class _AddFireState extends State<AddFire>{
  



String imagen;



File _imagenSeleccionada;  
String _opcionSeleccionadaSeveridad = 'Media';
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
          children:<Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              ),

          _dropdownSeveridad(),
          Divider(),
          _dropdownCanton(),
          Divider(),
          _dropdownDistrito(),
          Divider(),
          _crearImagen(),
          Divider(),
          Container(
            
          ),
          if(_imagenSeleccionada!=null)
              SizedBox(
                height: 180,
                child: Image.file(_imagenSeleccionada),
              ),
          Divider(),
          CupertinoButton.filled(
              child: Text(
                  "Añadir incendio"
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

//dropdownDistrito
List<DropdownMenuItem<String>> getOpcionesDropdown() {

    List<DropdownMenuItem<String>> lista = new List();

    _distritos.forEach( (distrito){

      lista.add( DropdownMenuItem(
        child: Text(distrito),
        value: distrito,
      ));

    });

    return lista;

  }

  Widget _dropdownDistrito() {

    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),   
        Expanded(
          child: DropdownButton(
            value: _opcionSeleccionadaDistrito,
            items: getOpcionesDropdown(),
            onChanged: (opt) {
              setState(() {
                _opcionSeleccionadaDistrito = opt;
              });
            },
          ),
        )

      ],
    );
  

  }

//dropdownSeveridad
List<DropdownMenuItem<String>> getOpcionesSeveridad() {

    List<DropdownMenuItem<String>> lista = new List();

    _severidad.forEach( (severidad){

      lista.add( DropdownMenuItem(
        child: Text(severidad),
        value: severidad,
      ));

    });

    return lista;

  }

  Widget _dropdownSeveridad() {

    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),   
        Expanded(
          child: DropdownButton(
            value: _opcionSeleccionadaSeveridad,
            items: getOpcionesSeveridad(),
            onChanged: (opt) {
              setState(() {
                _opcionSeleccionadaSeveridad = opt;
             
              });
            },
          ),
        )

      ],
    );

  }

  //dropdownCanton
List<DropdownMenuItem<String>> getOpcionesCantones() {

    List<DropdownMenuItem<String>> lista = new List();

    _cantones.forEach( (canton){

      lista.add( DropdownMenuItem(
        child: Text(canton),
        value: canton,
      ));

    });

    return lista;

  }

  Widget _dropdownCanton() {

    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),   
        Expanded(
          child: DropdownButton(
            value: _opcionSeleccionadaCanton,
            items: getOpcionesCantones(),
            onChanged: (opt) {
              setState(() {
                _opcionSeleccionadaCanton = opt;
              });
            },
          ),
        )

      ],
    );
  }

Widget _crearImagen(){
  return IconButton(
    icon: Icon(Icons.camera_alt),
    color: Colors.grey,
    onPressed: ()async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imagenSeleccionada = image;
    });
    }
  );
}
}