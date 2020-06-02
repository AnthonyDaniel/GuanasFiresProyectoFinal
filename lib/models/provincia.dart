
class Provincia {
  String codigo;
  String descripcion;

  Provincia({this.codigo, this.descripcion});

  factory Provincia.fromJson(Map<String, dynamic> json) {
    return Provincia(
      codigo: json["codigo"] as String,
      descripcion: json["descripcion"] as String,
    );
  }
}

class ProvinciaList {
  final List<Provincia> provincia;

  ProvinciaList({
    this.provincia,
  });

  factory ProvinciaList.fromJson(List<dynamic> parsedJson) {
    List<Provincia> provincia = new List<Provincia>();
    provincia = parsedJson.map((i)=>Provincia.fromJson(i)).toList();

    return new ProvinciaList(
        provincia: provincia
    );
  }
}
