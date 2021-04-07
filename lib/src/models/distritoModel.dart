import 'dart:convert';

List<Distrito> distritoFromJson(String str) => List<Distrito>.from(json.decode(str).map((x) => Distrito.fromJson(x)));

String distritoToJson(List<Distrito> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Distrito {
    Distrito({
        this.departamentoId,
        this.nombre,
        this.key,
    });

    int departamentoId;
    String nombre;
    String key;

    factory Distrito.fromJson(Map<String, dynamic> json) => Distrito(
        departamentoId: json["departamento_id"],
        nombre: json["nombre"],
        key: json["key"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "departamento_id:": departamentoId,
        "nombre": nombre,
        "key": key,
    };
}
