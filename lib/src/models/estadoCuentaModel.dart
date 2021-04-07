import 'dart:convert';

EstadoCuenta estadoCuentaFromJson(String str) => EstadoCuenta.fromJson(json.decode(str));

String estadoCuentaToJson(EstadoCuenta data) => json.encode(data.toJson());

class EstadoCuenta {
    EstadoCuenta({
        this.sumanDebitos,
        this.registrosDebitos,
        this.sumanCreditos,
        this.registrosCreditos,
    });

    int sumanDebitos;
    List<RegistrosDebito> registrosDebitos;
    int sumanCreditos;
    List<dynamic> registrosCreditos;

    factory EstadoCuenta.fromJson(Map<String, dynamic> json) => EstadoCuenta(
        sumanDebitos: json["suman_debitos"],
        registrosDebitos: List<RegistrosDebito>.from(json["registros_debitos"].map((x) => RegistrosDebito.fromJson(x))),
        sumanCreditos: json["suman_creditos"],
        registrosCreditos: List<dynamic>.from(json["registros_creditos"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "suman_debitos": sumanDebitos,
        "registros_debitos": List<dynamic>.from(registrosDebitos.map((x) => x.toJson())),
        "suman_creditos": sumanCreditos,
        "registros_creditos": List<dynamic>.from(registrosCreditos.map((x) => x)),
    };
}

class RegistrosDebito {
    RegistrosDebito({
        this.id,
        this.carteraId,
        this.sucursalId,
        this.oficinaId,
        this.clienteId,
        this.contratoId,
        this.fecha,
        this.tipo,
        this.formapagoId,
        this.documentoId,
        this.naturaleza,
        this.conceptoId,
        this.resolucionId,
        this.estado,
        this.contratoProductoId,
        this.productoId,
        this.periodo,
        this.cantidad,
        this.valor,
        this.barrioId,
        this.nodoId,
        this.estratoId,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt,
        this.estadoId,
        this.casasPasadas,
        this.edad,
        this.createdSucursalId,
        this.createdOficinaId,
        this.cobradorId,
    });

    int id;
    int carteraId;
    int sucursalId;
    int oficinaId;
    int clienteId;
    int contratoId;
    DateTime fecha;
    String tipo;
    dynamic formapagoId;
    int documentoId;
    String naturaleza;
    int conceptoId;
    int resolucionId;
    String estado;
    int contratoProductoId;
    int productoId;
    DateTime periodo;
    int cantidad;
    dynamic valor;
    int barrioId;
    int nodoId;
    int estratoId;
    int createdBy;
    int createdAt;
    int updatedBy;
    int updatedAt;
    int estadoId;
    int casasPasadas;
    int edad;
    int createdSucursalId;
    int createdOficinaId;
    dynamic cobradorId;

    factory RegistrosDebito.fromJson(Map<String, dynamic> json){ 
      var valor= '0';
      if(json["valor"] is int){
       valor= json["valor"].toString();
      }
      else if(json["valor"] is String){
         if(json["valor"]==null||json["valor"]==''){
           valor= '0';
         }
         else{
          valor= json["valor"].toString();
         }
      } 
      else if(json["valor"] is double){
        valor=json["valor"].toString();
      }
      return RegistrosDebito(
        id: json["id"],
        carteraId: json["cartera_id"],
        sucursalId: json["sucursal_id"],
        oficinaId: json["oficina_id"],
        clienteId: json["cliente_id"],
        contratoId: json["contrato_id"],
        fecha: DateTime.parse(json["fecha"]),
        tipo: json["tipo"],
        formapagoId: json["formapago_id"],
        documentoId: json["documento_id"],
        naturaleza: json["naturaleza"],
        conceptoId: json["concepto_id"],
        resolucionId: json["resolucion_id"],
        estado: json["estado"],
        contratoProductoId: json["contrato_producto_id"],
        productoId: json["producto_id"],
        periodo: DateTime.parse(json["periodo"]),
        cantidad: json["cantidad"],
        valor:  valor,
        barrioId: json["barrio_id"],
        nodoId: json["nodo_id"],
        estratoId: json["estrato_id"],
        createdBy: json["created_by"],
        createdAt: json["created_at"],
        updatedBy: json["updated_by"],
        updatedAt: json["updated_at"],
        estadoId: json["estado_id"],
        casasPasadas: json["casas_pasadas"],
        edad: json["edad"],
        createdSucursalId: json["created_sucursal_id"],
        createdOficinaId: json["created_oficina_id"],
        cobradorId: json["cobrador_id"],
    );}

    Map<String, dynamic> toJson() => {
        "id": id,
        "cartera_id": carteraId,
        "sucursal_id": sucursalId,
        "oficina_id": oficinaId,
        "cliente_id": clienteId,
        "contrato_id": contratoId,
        "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "tipo": tipo,
        "formapago_id": formapagoId,
        "documento_id": documentoId,
        "naturaleza": naturaleza,
        "concepto_id": conceptoId,
        "resolucion_id": resolucionId,
        "estado": estado,
        "contrato_producto_id": contratoProductoId,
        "producto_id": productoId,
        "periodo": "${periodo.year.toString().padLeft(4, '0')}-${periodo.month.toString().padLeft(2, '0')}-${periodo.day.toString().padLeft(2, '0')}",
        "cantidad": cantidad,
        "valor": valor,
        "barrio_id": barrioId,
        "nodo_id": nodoId,
        "estrato_id": estratoId,
        "created_by": createdBy,
        "created_at": createdAt,
        "updated_by": updatedBy,
        "updated_at": updatedAt,
        "estado_id": estadoId,
        "casas_pasadas": casasPasadas,
        "edad": edad,
        "created_sucursal_id": createdSucursalId,
        "created_oficina_id": createdOficinaId,
        "cobrador_id": cobradorId,
    };
}
