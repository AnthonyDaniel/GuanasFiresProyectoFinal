
class Distrito {
  int id;
  String codigo;
  String descripcion;
  String codProvi;
  String codCant;

  Distrito({this.id, this.codigo, this.descripcion,this.codProvi, this.codCant});

  factory Distrito.fromJson(Map<String, dynamic> json) {
    return Distrito(
      id: json["id"] as int,
      codigo: json["codigo"] as String,
      descripcion: json["descripcion"] as String,
      codProvi: json["codProvi"] as String,
      codCant: json["codCant"] as String,
    );
  }
}


class DistritoList {
  final List<Distrito> distrito;

  DistritoList({
    this.distrito,
  });

  factory DistritoList.fromJson(List<dynamic> parsedJson) {
    List<Distrito> distrito = new List<Distrito>();
    distrito = parsedJson.map((i)=>Distrito.fromJson(i)).toList();
    return new DistritoList(
        distrito: distrito
    );
  }
}
