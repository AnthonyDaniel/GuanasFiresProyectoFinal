
class Canton {
  int id;
  String codigo;
  String descripcion;
  String codProvi;

  Canton({this.id, this.codigo, this.descripcion,this.codProvi});

  factory Canton.fromJson(Map<String, dynamic> json) {
    return Canton(
      id: json["id"] as int,
      codigo: json["codigo"] as String,
      descripcion: json["descripcion"] as String,
      codProvi: json["codProvi"] as String,
    );
  }
}