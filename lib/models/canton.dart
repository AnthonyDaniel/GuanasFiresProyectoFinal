
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

class CantonList {
  final List<Canton> canton;

  CantonList({
    this.canton,
  });

  factory CantonList.fromJson(List<dynamic> parsedJson) {
    List<Canton> canton = new List<Canton>();
    canton = parsedJson.map((i)=>Canton.fromJson(i)).toList();
    return new CantonList(
        canton: canton
    );
  }
}
