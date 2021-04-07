import 'dart:convert';

List<PlanesProducto> planesProductoFromJson(String str) => List<PlanesProducto>.from(json.decode(str).map((x) => PlanesProducto.fromJson(x)));

String planesProductoToJson(List<PlanesProducto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlanesProducto {
    PlanesProducto({
        this.descripcion,
        this.id,
        this.idTipo,
        this.nombre,
        this.precio,
        this.urlImage,
    });

    String descripcion;
    int id;
    dynamic idTipo;
    String nombre;
    int precio;
    String urlImage;

    factory PlanesProducto.fromJson(Map<String, dynamic> json) => PlanesProducto(
        descripcion: json["descripcion"],
        id: json["id"],
        idTipo: json["id_tipo"],
        nombre: json["nombre"],
        precio: json["precio"],
        urlImage: json["url_image"],
    );

    Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "id": id,
        "id_tipo": idTipo,
        "nombre": nombre,
        "precio": precio,
        "url_image": urlImage,
    };
}