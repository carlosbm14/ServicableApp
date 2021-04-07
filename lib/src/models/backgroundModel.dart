import 'dart:convert';

List<Background> backgroundFromJson(String str) => List<Background>.from(json.decode(str).map((x) => Background.fromJson(x)));

String backgroundToJson(List<Background> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Background {
    Background({
        this.id,
        this.nombre,
        this.urlImage,
    });

    int id;
    String nombre;
    String urlImage;

    factory Background.fromJson(Map<String, dynamic> json) => Background(
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
