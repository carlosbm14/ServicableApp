import 'dart:convert';

import 'package:appservicable/src/models/estadisticaModel.dart';
import 'package:appservicable/src/services/apiServices.dart';
import 'package:appservicable/src/settings/persistence.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/smtp/server_smtp.dart';
import 'package:appservicable/src/widgets/functionsCommoms.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';

class FormularioViewModel extends ChangeNotifier {

enviarAumentodeMegas(
    BuildContext context,
    String producto,
    String plan,

  ) async {
    //   if (especifique.isEmpty) {
    //   validationFail(context, 'Debe ingresar una especificación.');
    // }
    
       final prefs= new PersistenceLocal();
      
      //enviar el correo
      final smtpServer = configMail();
      final message = Message()
        ..from = Address('jsegovia@servicable.com.pe', 'App Servicable')
        ..recipients.addAll(['jsegovia@servicable.com.pe', 'jmiranda707luis@gmail.com'])
        ..subject = 'Mensaje de App Servicable :: ${DateTime.now()}'
        ..text = prefs.nombres
        ..html =
            "<h1>Solicitud Aumento de Megas</h1>\n<p>Nombres y Apellidos: ${prefs.nombres}</p>\n<p>Teléfono: ${prefs.telefono}</p>\n<p>Email: ${prefs.email}</p>\n<p>Tipo de Documento: ${prefs.tipodni}</p>\n<p>Número de Documento: ${prefs.numerodni}</p>\n<p>Departamento: ${prefs.departamento}</p>\n<p>Distrito: ${prefs.distrito}</p>\n<p>Producto: $producto</p>\n<p>Plan: $plan</p>";

      try {
        alertLoading(context, 'Formulario');
        await send(message, smtpServer);
        Navigator.pop(context);
        Navigator.pop(context);
        /*Navigator.of(context)
            .pushNamedAndRemoveUntil('initial', ModalRoute.withName('/'));*/
        _mostrarAlert(context, 1);
      } on MailerException catch (e) {
        Navigator.pop(context);
        _mostrarAlert(context, 2);
      }
    
  }


  enviarSolicitudServicioTecnico(
    BuildContext context,
    String producto,
    String servicio,
    String especifique,
  ) async {
      if (especifique.isEmpty) {
      validationFail(context, 'Debe ingresar una especificación.');
    }
    else {
      final prefs= new PersistenceLocal();
      
      //enviar el correo
      final smtpServer = configMail();
      final message = Message()
        ..from = Address('jsegovia@servicable.com.pe', 'App Servicable')
        ..recipients.addAll(['jsegovia@servicable.com.pe', 'jmiranda707luis@gmail.com'])
        ..subject = 'Mensaje de App Servicable :: ${DateTime.now()}'
        ..text = prefs.nombres
        ..html =
            "<h1>Solicitud de Servicio Técnico</h1>\n<p>Nombres y Apellidos: ${prefs.nombres}</p>\n<p>Teléfono: ${prefs.telefono}</p>\n<p>Email: ${prefs.email}</p>\n<p>Tipo de Documento: ${prefs.tipodni}</p>\n<p>Número de Documento: ${prefs.numerodni}</p>\n<p>Departamento: ${prefs.departamento}</p>\n<p>Distrito: ${prefs.distrito}</p>\n<p>Producto: $producto</p>\n<p>Servicio: $servicio</p>\n<p>Especificación: $especifique</p>";

      try {
        alertLoading(context, 'Formulario');
        await send(message, smtpServer);
        Navigator.pop(context);
        Navigator.pop(context);
        /*Navigator.of(context)
            .pushNamedAndRemoveUntil('initial', ModalRoute.withName('/'));*/
        _mostrarAlert(context, 1);
      } on MailerException catch (e) {
        Navigator.pop(context);
        _mostrarAlert(context, 2);
      }
    }
  }

  enviarEstadistica(BuildContext context, String nombre, String telefono,
      String correo, String departamento, String distrito, String recibirPublicidad) async {
    if (nombre.isEmpty) {
      validationFail(context, 'Debe ingresar Nombre.');
    } else if (telefono.isEmpty) {
      validationFail(context, 'Debe ingresar Teléfono.');
    } 
    else if (departamento.isEmpty) {
      validationFail(context, 'Debe ingresar Departamento.');
    }
    else if (distrito.isEmpty) {
      validationFail(context, 'Debe ingresar Distrito.');
    } else {
      //enviar datos del formulario a firebase
      final estadistica = new Estadistica();
      estadistica.nombre = nombre.toUpperCase();
      estadistica.distrito = distrito.toUpperCase();
      estadistica.departamento = departamento.toUpperCase();
      estadistica.correo = correo.toUpperCase();
      estadistica.telefono = telefono;
      estadistica.recibirPublicidad = recibirPublicidad.toUpperCase();
      estadistica.fechaHora = DateTime.now().toString();
      final jsons = json.encode(estadistica);
      alertLoading(context, 'Formulario');
      final statusCode = await enviarEstadisticasFirebase(jsons);
      Navigator.pop(context);
      if (statusCode == 200) {
        final prefs = PersistenceLocal();
        prefs.sentEmail = true;
        Navigator.pushReplacementNamed(context, 'productosMain');
        _mostrarAlert(context, 1);
      } else {
        _mostrarAlert(context, 2);
      }
    }
  }

  enviarCorreo(
      BuildContext context,
      String nombre,
      String telefono,
      String email,
      String direccion,
      String departamento,
      String distrito,
      String plan,
      String tipoContacto,
      String recibirPublicidad) async {
    if (nombre.isEmpty) {
      validationFail(context, 'Debe ingresar Nombre.');
    } else if (telefono.isEmpty) {
      validationFail(context, 'Debe ingresar Teléfono.');
    } else if (email.isEmpty) {
      validationFail(context, 'Debe ingresar Correo.');
    } else if (direccion.isEmpty) {
      validationFail(context, 'Debe ingresar Dirección.');
    } 
    else if (departamento.isEmpty) {
      validationFail(context, 'Debe ingresar Departamento.');
    }
    else if (distrito.isEmpty) {
      validationFail(context, 'Debe ingresar Distrito.');
    } else {
      //enviar el correo
      final smtpServer = configMail();
      final message = Message()
        ..from = Address('clientes@servicable.com.pe', 'App Servicable')
        ..recipients.addAll(['clientes@servicable.com.pe'])
        ..subject = 'Mensaje de App Servicable :: ${DateTime.now()}'
        ..text = nombre
        ..html =
            "<h1>Servicable App</h1>\n<p>Nombres y Apellidos: $nombre</p>\n<p>Teléfono: $telefono</p>\n<p>Email: $email</p>\n<p>Dirección: $direccion</p>\n<p>Departamento: $departamento</p>\n<p>Distrito: $distrito</p>\n<p>Plan: $plan</p>\n<p>Tipo de Contacto: $tipoContacto</p>\n<p>Recibir Publicidad: $recibirPublicidad</p>";

      try {
        alertLoading(context, 'Formulario');
        await send(message, smtpServer);
        Navigator.pop(context);

        Navigator.of(context)
            .pushNamedAndRemoveUntil('initial', ModalRoute.withName('/'));
        _mostrarAlert(context, 1);
      } on MailerException catch (e) {
        Navigator.pop(context);
        _mostrarAlert(context, 2);
      }
    }
  }

  void _mostrarAlert(context, flag) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Text('Formulario', style: TextStyle(fontSize: f(24))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                flag == 1
                    ? Text('Datos enviados con éxito.')
                    : Text('Ha ocurrido un error durante su envío.'),
                //FlutterLogo(size:100.0),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ACEPTAR'),
              ),
            ],
          );
        });
  }
}
