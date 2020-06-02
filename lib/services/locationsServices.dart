import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:guanasfires/models/canton.dart';
import 'package:guanasfires/models/distritos.dart';
import 'dart:convert';

import 'package:guanasfires/models/provincia.dart';

class LocationsServices {

  List<Provincia> provincias;
  List<Canton> cantones;
  List<Distrito> distritos;

  LocationsServices(){
    loadProvincias();
    loadCantones();
    loadDistritos();
  }

  Future<String> _loadProvincias() async {
    return await rootBundle.loadString('resources/Provincias.json');
  }
  Future<String> _loadCantones() async {
    return await rootBundle.loadString('resources/Cantones.json');
  }
  Future<String> _loadDistritos() async {
    return await rootBundle.loadString('resources/Distritos.json');
  }

  Future loadProvincias() async {
    String jsonString = await _loadProvincias();
    final jsonResponse = json.decode(jsonString);
    ProvinciaList provinciaList = new ProvinciaList.fromJson(jsonResponse);


    this.provincias = provinciaList.provincia;
  }

  Future loadCantones() async {
    String jsonString = await _loadCantones();
    final jsonResponse = json.decode(jsonString);
    CantonList cantonList = new CantonList.fromJson(jsonResponse);

    this.cantones = cantonList.canton;
  }

  Future loadDistritos() async {
    String jsonString = await _loadDistritos();
    final jsonResponse = json.decode(jsonString);
    DistritoList distritoList = new DistritoList.fromJson(jsonResponse);

    this.distritos = distritoList.distrito;
  }

}
