import 'package:appservicable/src/pages/dni_page.dart';
import 'package:appservicable/src/pages/formularioMasProductos_Page.dart';
import 'package:appservicable/src/pages/formularioQuieroComprar_Page.dart';
import 'package:appservicable/src/pages/formulario_aumentodeMegas.dart';
import 'package:appservicable/src/pages/formulario_solicitudServicioTecnico.dart';
import 'package:appservicable/src/pages/pageViewCanales_page.dart';
import 'package:appservicable/src/pages/parilla_home_page.dart';
import 'package:appservicable/src/pages/productosCategory_page.dart';
import 'package:appservicable/src/pages/productosPlanes_page.dart';
import 'package:appservicable/src/pages/productosTipos_page.dart';
import 'package:flutter/material.dart';
import 'package:appservicable/src/pages/home_page.dart';
import 'package:appservicable/src/pages/initial_page.dart';
import 'package:appservicable/src/pages/registro_page.dart';
import 'package:appservicable/src/pages/login_page.dart';
import 'package:appservicable/src/pages/contact_page.dart';
import 'package:appservicable/src/pages/dashboard_page.dart';
import 'package:appservicable/src/pages/recuperar_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder> {
    '/': (BuildContext context) => HomePage(),
    'initial': (BuildContext context) => InitialPage(),
    'registro': (BuildContext context) => RegistroPage(),
    'recuperar': (BuildContext context) => RecuperarPage(),
    'login': (BuildContext context) => LoginPage(),
    'dashboard': (BuildContext context) => DashboardPage(),
    'contacto': (BuildContext context) => ContactPage(),
    'PageViewCanales':(BuildContext context) => PageViewCanales(),
    'dni':(BuildContext context) => DniPage(),
    'parrillaHome':(BuildContext context) => ParrillaHome(),
    'productosMain':(BuildContext context) => ProductosMain(),
    'productosTipos':(BuildContext context) => ProductosTipos(),
    'productosPlanes':(BuildContext context) => ProductosPlanes(),
    'formularioMasProductos':(BuildContext context) => FormularioMasProductos(),
    'formularioQuieroComprar':(BuildContext context) => FormularioQuieroComprar(),
    'formularioServTecnico':(BuildContext context) => FormularioSolicitudServTecnico(),
    'formularioAmentodeMegas':(BuildContext context) => FormularioAumentoMegas(),
    

  };
}