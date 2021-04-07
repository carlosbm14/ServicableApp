import 'dart:convert';

List<TipoProducto> tipoProductoFromJson(String str) => List<TipoProducto>.from(json.decode(str).map((x) => TipoProducto.fromJson(x)));

String tipoProductoToJson(List<TipoProducto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TipoProducto {
    TipoProducto({
        this.descripcion,
        this.id,
        this.idCategoria,
        this.nombre,
        this.precio,
        this.urlImage,
        this.urlbackground
    });

    String descripcion;
    int id;
    dynamic idCategoria;
    String nombre;
    dynamic precio;
    String urlImage;
    String urlbackground;

    factory TipoProducto.fromJson(Map<String, dynamic> json) => TipoProducto(
        descripcion: json["descripcion"],
        id: json["id"],
        idCategoria: json["id_categoria"],
        nombre: json["nombre"],
        precio: json["precio"],
        urlImage: json["url_image"],
        urlbackground: json["url_background"]
    );

    Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "id": id,
        "id_categoria": idCategoria,
        "nombre": nombre,
        "precio": precio,
        "url_image": urlImage,
        "url_background": urlbackground
    };
}