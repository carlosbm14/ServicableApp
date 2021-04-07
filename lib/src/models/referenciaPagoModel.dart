import 'dart:convert';

List<ReferenciaPago> referenciaPagoFromJson(String str) => List<ReferenciaPago>.from(json.decode(str).map((x) => ReferenciaPago.fromJson(x)));

String referenciaPagoToJson(List<ReferenciaPago> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReferenciaPago {
    ReferenciaPago({
        this.referenciaPago,
    });

    String referenciaPago;

    factory ReferenciaPago.fromJson(Map<String, dynamic> json) => ReferenciaPago(
        referenciaPago: json["referencia_pago"],
    );

    Map<String, dynamic> toJson() => {
        "referencia_pago": referenciaPago,
    };
}