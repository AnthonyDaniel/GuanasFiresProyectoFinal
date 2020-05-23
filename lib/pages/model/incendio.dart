
import 'package:firebase_database/firebase_database.dart';

class Incendio {
  String _id;
  String _canton;
  String _distrito;
  String _severidad;
  String _foto;
  String _video;
  String _ubicacionGoogle;
  String _fecha;
  
  Incendio(this._id,this._canton,this._distrito,this._severidad,this._foto,
      this._video,this._ubicacionGoogle,this._fecha);

  
  Incendio.map(dynamic obj){
    this._canton = obj['canton'];
    this._distrito = obj['distrito'];
    this._severidad = obj['severidad'];
    this._foto = obj['foto'];
    this._video = obj['video'];
    this._ubicacionGoogle = obj['ubicacionGoogle'];
    this._fecha = obj['fecha'];
  }

  String get id => _id;
  String get canton => _canton;
  String get distrito => _distrito;
  String get severidad => _severidad;
  String get foto => _foto;
  String get video => _video;
  String get ubicacionGoogle => _ubicacionGoogle;
  String get fecha => _ubicacionGoogle;

  Incendio.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _canton = snapshot.value['canton'];
    _distrito = snapshot.value['distrito'];
    _severidad = snapshot.value['severidad'];
    _foto = snapshot.value['foto'];
    _video = snapshot.value['video'];
    _ubicacionGoogle = snapshot.value['ubicacionGoogle'];
    _fecha = snapshot.value['fecha'];
  }
}


