
import 'dart:convert';

List<Carrusel> carruselFromJson(String str) => List<Carrusel>.from(json.decode(str).map((x) => Carrusel.fromJson(x)));

String carruselToJson(List<Carrusel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Carrusel {
    Carrusel({
        this.id,
        this.nombre,
        this.urlImage,
    });

    int id;
    String nombre;
    String urlImage;

    factory Carrusel.fromJson(Map<String, dynamic> json) => Carrusel(
        id: json["id"],
        nombre: json["nombre"],
        urlImage: json["url_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "url_image": urlImage,
    };
}