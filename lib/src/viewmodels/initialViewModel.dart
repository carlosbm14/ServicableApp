import 'package:appservicable/src/settings/persistence.dart';
import 'package:flutter/material.dart';

class InitialViewModel extends ChangeNotifier {
  
   goConoceMasProductosPage(BuildContext context){
     final prefs= PersistenceLocal();
      //validar si ya envio el formulario (al enviar crear una variable en persistencia con valor true)
     if(prefs.sentEmail==true){
       //ir a categoria productos
       Navigator.pushNamed(context, 'productosMain');
     }
     else{
       Navigator.pushNamed(context, 'formularioMasProductos');
       //al aceptar el formulario,variable==true y reenvio
     }
   }
}
