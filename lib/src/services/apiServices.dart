import 'dart:convert';

import 'package:appservicable/src/models/backgroundModel.dart';
import 'package:appservicable/src/models/carruselModel.dart';
import 'package:appservicable/src/models/planesAumentoMegasModel.dart';
import 'package:appservicable/src/models/planesProductoModel.dart';
import 'package:appservicable/src/models/productCategoryModel.dart';
import 'package:appservicable/src/models/productoAumentodeMegas.dart';
import 'package:appservicable/src/models/productoSolicitud.dart';
import 'package:appservicable/src/models/programacionModel.dart';
import 'package:appservicable/src/models/promoModel.dart';
import 'package:appservicable/src/models/servicioSolicitudServicio.dart';
import 'package:appservicable/src/models/tipoProductoModel.dart';
import 'package:appservicable/src/models/departamentoModel.dart';
import 'package:appservicable/src/models/distritoModel.dart';
import 'package:appservicable/src/settings/persistence.dart';
import 'package:appservicable/src/viewmodels/dniViewModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appservicable/src/models/usuarioModel.dart';
import 'package:provider/provider.dart';

final prefs = new PersistenceLocal();
final String _firebaseToken = 'AIzaSyBxkKITktwuMtVIfKYkdE9BcrC147vg1k0';

Future registrarUsuarioAuth(
  BuildContext context,
  String email,
  String password, {
  String provincia,
  String departamento,
  String distrito,
  String nombres,
  String referencia,
  String telefono,
  int cliente,
}) async {
  final authData = {
    'email': email,
    'password': password,
    'returnSecureToken': true
  };
  final url =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken";
  // 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken';
  final body = json.encode(authData);
  final resp = await http.post(url, body: body);

  Map<String, dynamic> decodedResp = json.decode(resp.body);
  if (decodedResp.containsKey('idToken')) {
    prefs.token = decodedResp['idToken']; //aqui guardo mi token
    await _crearUsuario(
      context,
      decodedResp['localId'],
      email,
      provincia: provincia,
      departamento: departamento,
      distrito: distrito,
      referencia: referencia,
      telefono: telefono,
      nombres: nombres,
      cliente: cliente,
    ); //aqui le paso el id del usuario
    prefs.uidUser = decodedResp['localId'];
    return {
      'ok': true,
      'token': decodedResp['idToken'],
      'idUser': decodedResp['localId']
    }; //este idlocal es el que le voy a asignar al usuario en el arbol json
  } else {
    return {'ok': false, 'mensaje': decodedResp['error']['message']};
  }
}

Future<String> _crearUsuario(
  BuildContext context,
  String idUsuario,
  String email, {
  String provincia,
  String departamento,
  String distrito,
  String nombres,
  String referencia,
  String telefono,
  int cliente,
}) async {
  final String _url = 'https://servicableapp-74e44.firebaseio.com';
  //https://enkontrol-7229c.firebaseio.com/usuarios/abcd123/productos nuevaurl con id usuario
  final urlCrearUsuario =
      '$_url/user.json?auth=${prefs.token}'; //aqui inserto la url restante de productos (en firebase) y le agrego el .json ajuro
  Usuario usuario = new Usuario();
  usuario.id = idUsuario;
  usuario.email = email;
  usuario.departamento = departamento;
  usuario.distrito = distrito;
  usuario.telefono = telefono;
  usuario.cliente = cliente;
  usuario.referencia = referencia;
  usuario.nombres = nombres;
  usuario.dni= Provider.of<DniViewModel>(context, listen:false).dni;
  usuario.tipoDni= Provider.of<DniViewModel>(context, listen:false).tipodni;

  final resp =
      await http.post(urlCrearUsuario, body: json.encode(usuario.toJson()));
  final respDecode = json.decode(resp
      .body); //aqui veo cual es la respuesta que me envia firebase si fue exitosa o error
  prefs.keyUserLog =
      respDecode['name']; //aqui guardo la key principal de mi usuario
      
  return 'Ok';
}

Future autenticarUsuarioLogueado(String email, String password) async {
  try {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken';

    final body = json.encode(authData);
    final resp = await http.post(url, body: body);

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    //print(decodedResp);
    if (decodedResp.containsKey('idToken')) {
      prefs.token = decodedResp['idToken'];
      prefs.uidUser = decodedResp['localId']; //aqui guardo mi token
      return {
        'ok': true,
        'token': decodedResp['idToken'],
        'idUser': decodedResp['localId']
      }; //este idlocal es el que le voy a asignar al usuario en el arbol json
    } else {
      String msj = (decodedResp['error']['message'] == 'INVALID_PASSWORD')
          ? 'Contraseña incorrecta.'
          : (decodedResp['error']['message'] == 'EMAIL_NOT_FOUND')
              ? 'Email no existe en la Base de datos.'
              : 'Ha ocurrido un error en la validación.';
      return {'ok': false, 'mensaje': msj};
    }
  } catch (e) {
    return {'ok': false, 'mensaje': 'Ha ocurrido un error.'};
  }
}

Future<List<Promo>> obtenerListaPromos() async {
  try {
    final url = 'https://servicableapp-74e44.firebaseio.com/images.json';
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    if (decodedResp != null) {
      final ok = decodedResp;
      List<Promo> promos = [];
      if (ok is List) {
        for (var i = 0; i < ok.length; i++) {
          Map map = ok[i];
          var modelo = Promo.fromJson(map);
          promos.add(modelo);
        }
      } else {
        Map map = ok;
        var modelo = Promo.fromJson(map);
        promos.add(modelo);
      }

      return promos;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

//imagenes del carrusel
Future<List<Carrusel>> obtenerListaCarrusel() async {
  try {
    final url = 'https://servicableapp-74e44.firebaseio.com/carrusel_imagenes.json';
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    if (decodedResp != null) {
      final ok = decodedResp;
      List<Carrusel> carru = [];
       if(ok is List){
        for (var campos in ok) {
        var modelo = Carrusel.fromJson(campos);
        carru.add(modelo);
      }
     }
     else if(ok is Map){
       ok.forEach((id, campos){
          var modelo = Carrusel.fromJson(campos);
          carru.add(modelo);
       });
     }
       
      

      return carru;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

//categoria productos (principal 1)
Future<List<ProductCategory>> obtenerListaProductosPrincipal() async {
  try {
    final url = 'https://servicableapp-74e44.firebaseio.com/categoria_productos.json';
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    if (decodedResp != null) {
      final ok = decodedResp;
      List<ProductCategory> product = [];
       if(ok is List){
        for (var campos in ok) {
        var modelo = ProductCategory.fromJson(campos);
        product.add(modelo);
      }
     }
     else if(ok is Map){
       ok.forEach((id, campos){
          var modelo = ProductCategory.fromJson(campos);
          product.add(modelo);
       });
     }
      
          

      return product;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

//tipos productos (segunda)
Future<List<TipoProducto>> obtenerListaTipoProductos() async {
  try {
    final url = 'https://servicableapp-74e44.firebaseio.com/tipos_producto.json';
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    if (decodedResp != null) {
      final ok = decodedResp;
      List<TipoProducto> tipoProd = [];
      if(ok is List){
        for (var campos in ok) {
        var modelo = TipoProducto.fromJson(campos);
        tipoProd.add(modelo);
      }
     }
     else if(ok is Map){
      ok.forEach((id, campos){
          var modelo = TipoProducto.fromJson(campos);
          tipoProd.add(modelo);
       });
     }
       
     

      return tipoProd;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}


//planes formulario Aumento de Megas
Future<List<PlanesAumentoMegas>> getPlanesAumentodeMegas() async {
  try {
    final url = 'https://servicableapp-74e44.firebaseio.com/planes_producto_formulario_aumentodemegas.json';
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    if (decodedResp != null) {
      final ok = decodedResp;
     List<PlanesAumentoMegas> serv = [];
     if(ok is List){
        for (var campos in ok) {
        var modelo = PlanesAumentoMegas.fromJson(campos);
        serv.add(modelo);
      }
     }
     else if(ok is Map){
      ok.forEach((id, campos){
          var modelo = PlanesAumentoMegas.fromJson(campos);
          serv.add(modelo);
       });
     }
     
     
      return serv;
    } else {
      return [];
    }
  } catch (e) {
    print(e);
    return [];
  }
}

//servicios formulario solicitud de servicios
Future<List<ServicioSolicitud>> getServiciosSolicitudServicios() async {
  try {
    final url = 'https://servicableapp-74e44.firebaseio.com/servicios_producto_formulario_solicituddeservicios.json';
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    if (decodedResp != null) {
      final ok = decodedResp;
     List<ServicioSolicitud> serv = [];
     if(ok is List){
        for (var campos in ok) {
        var modelo = ServicioSolicitud.fromJson(campos);
        serv.add(modelo);
      }
     }
     else if(ok is Map){
      ok.forEach((id, campos){
          var modelo = ServicioSolicitud.fromJson(campos);
          serv.add(modelo);
       });
     }
    
     
      return serv;
    } else {
      return [];
    }
  } catch (e) {
    print(e);
    return [];
  }
}

//productos formulario solicitud de servicios
Future<List<ProductoSolicitud>> getProductosSolicitudServicios() async {
  try {
    final url = 'https://servicableapp-74e44.firebaseio.com/productos_formulario_solicituddeservicios.json';
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    if (decodedResp != null) {
      final ok = decodedResp;
      List<ProductoSolicitud> prod = [];
      if(ok is List){
       for (var i = 0; i < ok.length; i++) {
          Map map = ok[i];
          var modelo = ProductoSolicitud.fromJson(map);
          prod.add(modelo);
        }
     }
     else if(ok is Map){
     ok.forEach((id, campos){
          var modelo = ProductoSolicitud.fromJson(campos);
          prod.add(modelo);
       });
     }
      
      return prod;
    } else {
      return [];
    }
  } catch (e) {
    print(e);
    return [];
  }
}

//backgrounds fondos de pantalla
Future<List<Background>> obtenerListaBackgrounds() async {
  try {
    final url = 'https://servicableapp-74e44.firebaseio.com/backgrounds.json';
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    if (decodedResp != null) {
      final ok = decodedResp;
      List<Background> back = [];
      if (ok is List) {
        for (var i = 0; i < ok.length; i++) {
          Map map = ok[i];
          var modelo = Background.fromJson(map);
          back.add(modelo);
        }
      } else {
        Map map = ok;
        var modelo = Background.fromJson(map);
        back.add(modelo);
      }

      return back;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

//planes productos (tercera)
Future<List<PlanesProducto>> obtenerListaPlanesProductos() async {
  try {
    final url = 'https://servicableapp-74e44.firebaseio.com/planes_producto.json';
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    if (decodedResp != null) {
      final ok = decodedResp;
      List<PlanesProducto> planProd = [];
      if(ok is List){
        for (var campos in ok) {
        var modelo = PlanesProducto.fromJson(campos);
        planProd.add(modelo);
      }
     }
     else if(ok is Map){
     ok.forEach((id, campos){
          var modelo = PlanesProducto.fromJson(campos);
          planProd.add(modelo);
       });
     }
      return planProd;
    } else {
      return [];
    }
  } catch (e) {
    print(e);
    return [];
  }
}

///lista de distritos de dropdowns
Future<List<Distrito>> obtenerListaDistritos() async {
  try {
    final url = 'https://servicableapp-74e44.firebaseio.com/distritos.json';
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    if (decodedResp != null) {
      final ok = decodedResp;
      List<Distrito> back = [];
      if(ok is List){
       for (var i = 0; i < ok.length; i++) {
          Map map = ok[i];
          var modelo = Distrito.fromJson(map);
          back.add(modelo);
        }
     }
     else if(ok is Map){
     ok.forEach((id, campos){
          var modelo = Distrito.fromJson(campos);
          back.add(modelo);
       });
     }
      
      return back;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

///lista de departamentos de dropdowns
Future<List<Departamento>> obtenerListaDepartamentos() async {
  try {
    final url = 'https://servicableapp-74e44.firebaseio.com/departamentos.json';
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    if (decodedResp != null) {
     final ok = decodedResp;
      List<Departamento> back = [];
      

       if(ok is List){
       for (var i = 0; i < ok.length; i++) {
          Map map = ok[i];
          var modelo = Departamento.fromJson(map);
          back.add(modelo);
        }
     }
     else if(ok is Map){
     ok.forEach((id, campos){
          var modelo = Departamento.fromJson(campos);
          back.add(modelo);
       });
     }
      
      return back;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

Future<List<Programacion>> obtenerListaProgramacion() async {
  try {
    final url = 'https://servicableapp-74e44.firebaseio.com/programacion.json';
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    if (decodedResp != null) {
      final ok = decodedResp;
      List<Programacion> back = [];

      if(ok is List){
       for (var i = 0; i < ok.length; i++) {
          Map map = ok[i];
          var modelo = Programacion.fromJson(map);
          back.add(modelo);
        }
     }
     else if(ok is Map){
     ok.forEach((id, campos){
          var modelo = Programacion.fromJson(campos);
          back.add(modelo);
       });
     }
      
      return back;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }

   
}

Future<int> enviarEstadisticasFirebase(String json) async {

     final url= 'https://servicableapp-74e44.firebaseio.com/estadistica.json';
    
    final resp = await http.post(url, body: json);
    
    return resp.statusCode;
    
   }


   Future<List<ProductoAumentodeMegas>> getProductosAumentodeMegas() async {
  try {
    final url = 'https://servicableapp-74e44.firebaseio.com/productos_formulario_aumentodemegas.json';
    final resp = await http.get(url);

    final decodedResp = json.decode(resp.body);
    if (decodedResp != null) {
      final ok = decodedResp;
      List<ProductoAumentodeMegas> prod = [];
      if(ok is List){
       for (var i = 0; i < ok.length; i++) {
          Map map = ok[i];
          var modelo =  ProductoAumentodeMegas.fromJson(map);
          prod.add(modelo);
        }
     }
     else if(ok is Map){
     ok.forEach((id, campos){
          var modelo = ProductoAumentodeMegas.fromJson(campos);
          prod.add(modelo);
       });
     }
      
     
     
     return prod;
    } else {
      return [];
    }
  } catch (e) {
    print(e);
    return [];
  }
}
