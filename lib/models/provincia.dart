
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