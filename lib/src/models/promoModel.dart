import 'dart:convert';

List<Promo> promoFromJson(String str) => List<Promo>.from(json.decode(str).map((x) => Promo.fromJson(x)));

String promoToJson(List<Promo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Promo {
    Promo({
        this.nombre,
        this.url,
        this.modulo,
    });

    String nombre;
    String url;
    String modulo;

    factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        nombre: json["nombre"],
        url: json["url"],
        modulo: json["modulo"]
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "url": url,
        "modulo": modulo,
    };
}