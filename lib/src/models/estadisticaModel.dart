import 'dart:convert';

List<Estadistica> estadisticaFromJson(String str) => List<Estadistica>.from(json.decode(str).map((x) => Estadistica.fromJson(x)));

String estadisticaToJson(List<Estadistica> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Estadistica {
    Estadistica({
        this.correo,
        this.departamento,
        this.distrito,
        this.nombre,
        this.recibirPublicidad,
        this.telefono,
        this.fechaHora
    });
    
    String fechaHora;
    String correo;
    String departamento;
    String distrito;
    String nombre;
    String recibirPublicidad;
    String telefono;

    factory Estadistica.fromJson(Map<String, dynamic> json) => Estadistica(
        correo: json["correo"],
        distrito: json["distrito"],
        nombre: json["nombre"],
        recibirPublicidad: json["recibirPublicidad"],
        telefono: json["telefono"],
        departamento: json["departamento"]
    );

    Map<String, dynamic> toJson() => {
        "correo": correo,
        "distrito": distrito,
        "nombre": nombre,
        "recibirPublicidad": recibirPublicidad,
        "telefono": telefono,
        "fechaHora": fechaHora,
        "departamento": departamento,
    };
}