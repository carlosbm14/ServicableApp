import 'dart:convert';

import 'package:appservicable/src/models/estadoCuentaModel.dart';
import 'package:appservicable/src/models/productosEstadoCuentaModel.dart';
import 'package:appservicable/src/models/referenciaPagoModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'dart:io';
import 'dart:async';

class EstadoCuentaViewModel extends ChangeNotifier {
  EstadoCuenta _estadoCuenta;
  List<EstadoCuenta> _estadoCuentaList=[];
  List<ProductosEstadoCuenta> _listProductosEstadoCuenta;
  List<ReferenciaPago> _refPago = [];
  
  get estadoCuentaList {
    return _estadoCuentaList;
  }

  set estadoCuentaList(List<EstadoCuenta> value) {
    this._estadoCuentaList = value;
    notifyListeners();
  }

  get refPago {
    return _refPago;
  }

  set refPago(List<ReferenciaPago> value) {
    this._refPago = value;
    notifyListeners();
  }

  get listProductosEstadoCuenta {
    return _listProductosEstadoCuenta;
  }

  set listProductosEstadoCuenta(List<ProductosEstadoCuenta> value) {
    this._listProductosEstadoCuenta = value;
    notifyListeners();
  }

  get estadoCuenta {
    return _estadoCuenta;
  }

  set estadoCuenta(EstadoCuenta value) {
    this._estadoCuenta = value;
    notifyListeners();
  }

  Future<void> obtenerEstadoCuenta(
    int idUser,
    String email,
    List<ReferenciaPago> referenciaPago,
  ) async {
    try {
      List<ProductosEstadoCuenta> listTotalProEstCuent = [];
      List<EstadoCuenta> listEstadoCuen=[];
      for (var ref in referenciaPago) {
        final ioc = new HttpClient();
        ioc.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        final http = new IOClient(ioc);
        final resp = await http.post(
          'https://servicable.sigmapro.online/api-cartera/leer-cartera',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "user_id": "282",
            "user_email": "mmarcano@servicable.com.pe",
            "referencia_pago": ref.referenciaPago.toString()
          }),
        );
        
        List<ProductosEstadoCuenta> lisProEstCuent = [];
        EstadoCuenta lista = estadoCuentaFromJson(resp.body);

        var estadoCuenta = lista;
        List<int> idsProductos = [];
        for (var item in lista.registrosDebitos) {
          if (!idsProductos.contains(item.productoId)) {
            idsProductos.add(item.productoId);
          }
        }
        for (var id in idsProductos) {
          var producto =
              lista.registrosDebitos.where((i) => i.productoId == id).toList();
          double sumaDebitos = 0;
          for (var pro in producto) {
            sumaDebitos = sumaDebitos + double.parse(pro.valor.toString());
          }
          String nombrePro = (id == 6)
              ? 'DUOPACK'
              : (id == 9)
                  ? 'INTERNET'
                  : (id == 12)
                      ? 'TELEVISION'
                      : (id == 17)
                          ? 'TV ADULTOS'
                          : (id == 18)
                              ? 'TV BASICO DIGITAL'
                              : (id == 19)
                                  ? 'CAMARA'
                                  : (id == 27)
                                      ? 'INTERNET FTTH'
                                      : (id == 28)
                                      ? 'TV PREMIUM'
                                      : 'DESCONOCIDO';
          ProductosEstadoCuenta modelo = new ProductosEstadoCuenta(
            debitos: sumaDebitos,
            idProducto: id,
            nombreProducto: nombrePro,
          );
          lisProEstCuent.add(modelo);
          
        }
        for (var product in lisProEstCuent) {
          listTotalProEstCuent.add(product);
        }
         listEstadoCuen.add(estadoCuenta);
      } 
      this.estadoCuentaList = listEstadoCuen;
        this.listProductosEstadoCuenta = listTotalProEstCuent;//fin del ciclo for
    } catch (e) {
      print(e);
      return null;
    }

/*

        //valores reales
        final resp = await http.post(
       // 'https://pruebassrvcable.sigmapro.online/api-cartera/leer-cartera',
       'https://servicable-pruebas.sigmapro.online/api-cartera/leer-cartera',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "user_id": idUser.toString(),
          "user_email": email,
          "referencia_pago": ref.referenciaPago.toString()
        }),
      );
      List<ProductosEstadoCuenta> lisProEstCuent = [];
      EstadoCuenta lista = EstadoCuenta.fromJson(jsonDecode(resp.body));
      this.estadoCuenta = lista;
      List<int> idsProductos = [];
      for (var item in lista.registrosDebitos) {
        if (!idsProductos.contains(item.productoId)) {
          idsProductos.add(item.productoId);
        }
      }
      for (var id in idsProductos) {
        var producto =
            lista.registrosDebitos.where((i) => i.productoId == id).toList();
        double sumaDebitos = 0;
        for (var pro in producto) {
          sumaDebitos = sumaDebitos + double.parse(pro.valor);
        }
        String nombrePro=
        (id==6)?'DUOPACK':
        (id==9)?'INTERNET':
        (id==12)?'TELEVISION':
        (id==17)?'TV ADULTOS':
        (id==18)?'TV BASICO DIGITAL':
        (id==19)?'CAMARA':
        (id==27)?'INTERNET FTTH': 'DESCONOCIDO';
        ProductosEstadoCuenta modelo = new ProductosEstadoCuenta(
          debitos: sumaDebitos,
          idProducto: id,
          nombreProducto: nombrePro,
        );
        lisProEstCuent.add(modelo);
      }
      this.listProductosEstadoCuenta = lisProEstCuent;
      }//fin de for
      */
  }
}
