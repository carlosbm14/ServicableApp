import 'dart:convert';

List<ProductoAumentodeMegas> productoAumentodeMegasFromJson(String str) => List<ProductoAumentodeMegas>.from(json.decode(str).map((x) => ProductoAumentodeMegas.fromJson(x)));

String productoAumentodeMegasToJson(List<ProductoAumentodeMegas> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductoAumentodeMegas {
    ProductoAumentodeMegas({
        this.id,
        this.nombre,
        this.key,
    });

    int id;
    String nombre;
    String key;

    factory ProductoAumentodeMegas.fromJson(Map<String, dynamic> json) => ProductoAumentodeMegas(
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
