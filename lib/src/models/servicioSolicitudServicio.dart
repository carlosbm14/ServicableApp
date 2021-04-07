import 'dart:convert';

List<ServicioSolicitud> servicioFromJson(String str) => List<ServicioSolicitud>.from(json.decode(str).map((x) => ServicioSolicitud.fromJson(x)));

String servicioToJson(List<ServicioSolicitud> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServicioSolicitud {
    ServicioSolicitud({
        this.productoId,
        this.nombre,
        this.key,
    });

    int productoId;
    String nombre;
    String key;

    factory ServicioSolicitud.fromJson(Map<String, dynamic> json) => ServicioSolicitud(
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
