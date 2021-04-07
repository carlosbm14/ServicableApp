
import 'dart:convert';

import 'package:appservicable/src/models/referenciaPagoModel.dart';
import 'package:appservicable/src/services/dbLocal.dart';
import 'package:appservicable/src/settings/persistence.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/checkConnection.dart';
import 'package:appservicable/src/viewmodels/estadoCuentaViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'dart:io';
import 'dart:async';

import 'package:provider/provider.dart';

class DniViewModel extends ChangeNotifier {
  String _dni = '';
  String _tipodni = '';
  final prefs = new PersistenceLocal();
  
  get tipodni {
    return _tipodni;
  }

  set tipodni(String value) {
    this._tipodni = value;
    notifyListeners();
  }
  get dni {
    return _dni;
  }

  set dni(String value) {
    this._dni = value;
    notifyListeners();
  }
  

  Future<void> continuarPressed(
    BuildContext context,
    String dni,
    String tipoDni,
  ) async{
    if(dni==''){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Text('Validación Documento', style: TextStyle(fontSize: f(23))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Debe Ingresar un número de documento.'),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ACEPTAR'),
              ),
            ],
          );
        });
        return;
  }

       this.dni=dni;
       this.tipodni=(tipoDni=='1')?'DNI':
       (tipoDni=='2')?'CEDULA':
       (tipoDni=='3')?'CARNET DE EXTRANJERIA':
       (tipoDni=='4')?'RUC':
        (tipoDni=='5')?'PASAPORTE':
       (tipoDni=='6')?'PTP':
       'DNI';
       
      
    _alertLoading(context);
     final isOnline = await CheckConecction().isOnline(context);  
     if(isOnline){
          final respuesta = await getRefPago(context,tipoDni,dni,);
          if(respuesta!=null){
           prefs.isClient=(respuesta)?true:false;
           Navigator.pop(context);
           Navigator.of(context).pushNamed('login');
          }
          else{
            Navigator.pop(context);
          }
          
           }  
           else{
             Navigator.pop(context);
           }
           
        }
        
        void _alertLoading(context) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  title: Text('Confirmación DNI', style: TextStyle(fontSize: f(23))),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(width: w(10)),
                      Text(
                        'Cargando Data...',
                        style: TextStyle(fontSize: f(20)),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                  ],
                );
              });
        }
      
      Future<bool> getRefPago(
        BuildContext context,
      String identificacionId, String numeroIdentificacion,) async {
        try{
          final ioc = new HttpClient();
        ioc.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        final http = new IOClient(ioc);
        final resp = await http.post(
       'https://servicable.sigmapro.online/api-cartera/consultar-refpago-identificacion',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "user_id":"282",
          "user_email":"mmarcano@servicable.com.pe",
          "identificacion_id": identificacionId.toString(),
          "identificacion_numero": numeroIdentificacion.toString(),
        }),
      );
        final response=   referenciaPagoFromJson(resp.body);
        if(response.length==0){
          return false;
        }
        else{
          List<ReferenciaPago> refList= [];
          await DBLocalProvider.db.deleteAllReferencia();
          for (var ref in response) {
            ReferenciaPago modelo = new ReferenciaPago(
             referenciaPago: ref.referenciaPago
            );
            DBLocalProvider.db.insertRefPago(modelo);
            refList.add(modelo);
          }
          Provider.of<EstadoCuentaViewModel>(context, listen: false).refPago=refList;
          return true;
        }
        
        }
        catch(e){
           return null;
        }
        
    }

}
