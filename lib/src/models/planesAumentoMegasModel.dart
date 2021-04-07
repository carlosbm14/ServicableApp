import 'dart:convert';

List<PlanesAumentoMegas>planesaumentodemegasFromJson(String str) => List<PlanesAumentoMegas>.from(json.decode(str).map((x) => PlanesAumentoMegas.fromJson(x)));

String planesaumentodemegasToJson(List<PlanesAumentoMegas> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlanesAumentoMegas {
    PlanesAumentoMegas({
        this.productoId,
        this.nombre,
        this.key,
    });

    int productoId;
    String nombre;
    String key;

    factory PlanesAumentoMegas.fromJson(Map<String, dynamic> json) => PlanesAumentoMegas(
        productoId: int.parse(json["producto_id"].toString()),
        nombre: json["nombre"],
        key: json["key"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "producto_id:": productoId,
        "nombre": nombre,
        "key": key,
    };
}
