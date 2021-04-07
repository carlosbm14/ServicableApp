import 'dart:convert';

List<ProductoSolicitud> productoSolicitudFromJson(String str) => List<ProductoSolicitud>.from(json.decode(str).map((x) => ProductoSolicitud.fromJson(x)));

String productoSolicitudToJson(List<ProductoSolicitud> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductoSolicitud {
    ProductoSolicitud({
        this.id,
        this.nombre,
        this.key,
    });

    int id;
    String nombre;
    String key;

    factory ProductoSolicitud.fromJson(Map<String, dynamic> json) => ProductoSolicitud(
        id: json["id"],
        nombre: json["nombre"],
        key: json["key"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "id:": id,
        "nombre": nombre,
        "key": key,
    };
}
