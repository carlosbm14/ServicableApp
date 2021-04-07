import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        this.id,
        this.nombres,
        this.claveUsu,
        this.distrito,
        this.email,
        this.telefono,
        this.departamento,
        this.provincia,
        this.referencia,
        this.cliente,
        this.tipoDni,
        this.dni
    });
    
    String id;
    String nombres;
    String claveUsu;
    String distrito;
    String email;
    String telefono;
    String departamento;
    String provincia;
    int cliente; //1 cliente... 0 invitado
    String referencia;
    String dni;
    String tipoDni;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombres: json["nombres"],
        claveUsu: json["clave_usu"],
        distrito: json["distrito"],
        email: json["email"],
        telefono: json["telefono"],
        departamento: json["departamento"],
        provincia: json["provincia"],
        id: json["id"],
        cliente: json["cliente"],
        referencia: json["referencia"],
        dni: json["dni"],
        tipoDni: json["tipoDni"]
    );

    Map<String, dynamic> toJson() => {
        "nombres": nombres,
        "clave_usu": claveUsu,
        "distrito": distrito,
        "email": email,
        "telefono": telefono,
        "departamento": departamento,
        "provincia": provincia,
        "id": id,
        "cliente": cliente,
        "referencia": referencia,
        "dni": dni,
        "tipoDni": tipoDni
    };
}