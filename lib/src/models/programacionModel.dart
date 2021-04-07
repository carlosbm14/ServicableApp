import 'dart:convert';

List<Programacion> categoriaFromJson(String str) => List<Programacion>.from(json.decode(str).map((x) => Programacion.fromJson(x)));

String categoriaToJson(List<Programacion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Programacion {
    Programacion({
        this.nombre,
        this.url,
        this.categoria,
    });

    String nombre;
    String url;
    String categoria;

    factory Programacion.fromJson(Map<String, dynamic> json) => Programacion(
        nombre: json["nombre"],
        url: json["url"],
        categoria: json["categoria"]
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "url": url,
    };
}