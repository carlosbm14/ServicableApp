
import 'dart:convert';

List<ProductCategory> productCategoryFromJson(String str) => List<ProductCategory>.from(json.decode(str).map((x) => ProductCategory.fromJson(x)));

String productCategoryToJson(List<ProductCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductCategory {
    ProductCategory({
        this.id,
        this.nombre,
        this.urlImage,
    });

    int id;
    String nombre;
    String urlImage;

    factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
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