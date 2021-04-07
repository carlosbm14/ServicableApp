import 'dart:convert';

List<Departamento> departamentoFromJson(String str) => List<Departamento>.from(json.decode(str).map((x) => Departamento.fromJson(x)));

String departamentoToJson(List<Departamento> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Departamento {
    Departamento({
        this.id,
        this.nombre,
    });

    int id;
    String nombre;
    String key;

    factory Departamento.fromJson(Map<String, dynamic> json) => Departamento(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
