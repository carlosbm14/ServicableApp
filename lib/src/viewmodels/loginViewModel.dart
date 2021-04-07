
import 'dart:convert';
import 'dart:io';

import 'package:appservicable/src/models/referenciaPagoModel.dart';
import 'package:appservicable/src/models/usuarioModel.dart';
import 'package:appservicable/src/services/apiServices.dart';
import 'package:appservicable/src/services/dbLocal.dart';
import 'package:appservicable/src/settings/persistence.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/estadoCuentaViewModel.dart';
import 'package:appservicable/src/viewmodels/parrillaHomeViewModel.dart';
import 'package:appservicable/src/viewmodels/programacionViewModel.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/widgets/functionsCommoms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


import 'checkConnection.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;
  Usuario _userLogged;

  final prefs = new PersistenceLocal();

  get userLogged {
    return _userLogged;
  }

  set userLogged(Usuario value) {
    this._userLogged = value;
    notifyListeners();
  }

  get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    this._isLoading = value;
    notifyListeners();
  }
  
  Future<void> reintentar(BuildContext context)async{
        _alertLoading(context);
           final isOnline = await CheckConecction().isOnline(context);  

     if(isOnline){
       final vm= Provider.of<PromosViewModel>(context, listen: false);
      vm.obtenerBackgrounds();
      vm.obtenerpromos();
      vm.obtenerCarruselImages();
      vm.obtenerServiciosSolicitudServicios();
      vm.obtenerDistritos();
      vm.obtenerCategoriaProductos();//principal
      vm.obtenerTiposProductos();//tipos
      vm.planesProductos();//descripcion
     // vm.obtenerDepartamentos();
     // vm.obtenerProductosSolicitudServicios();
      vm.obtenerPlanesAumentodemegas();
       Provider.of<ProgramacionViewModel>(context, listen: false)
        .obtenerprogramacion();
        Navigator.pop(context);
        Navigator.of(context).pushNamedAndRemoveUntil('initial', (Route<dynamic> route) => false);

     }
     else{
       Navigator.pop(context);
       alertTryAgain(context);
     }
  }

  Future<void> loginButtonPressed(
      BuildContext context, String pass, String user, bool cliente) async {
    if (pass == "" || user == "") {
      _alertFail(context, 'Debe llenar todos los datos del formulario.');
    } else {
      _alertLoading(context);
      
      final isOnline = await CheckConecction().isOnline(context);
      if (isOnline) {

        final Map<String, dynamic> result = await autenticarUsuarioLogueado(user,pass);
        final usuario = await obtenerMiUsuario();
        
        prefs.email=user;
        prefs.password=pass;
        
        if (result['ok'] && usuario!=null){ 
          var tipoDni = usuario.tipoDni;
          prefs.tipodni= usuario.tipoDni;
          prefs.numerodni= usuario.dni;
          prefs.email= usuario.email;
          prefs.distrito= usuario.distrito;
          prefs.nombres= usuario.nombres;
          prefs.telefono= usuario.telefono;
          prefs.departamento= usuario.departamento;
           
      var tipodni=(tipoDni=='DNI')?'1':
       (tipoDni=='CEDULA')?'2':
       (tipoDni=='CARNET DE EXTRANJERIA')?'3':
       (tipoDni=='RUC')?'4':
        (tipoDni=='PASAPORTE')?'5':
       (tipoDni=='PTP')?'6':
       '1';
          //////////////////////////// OBTENER REFERENCIA DE PAGO ////////////////////////
          final respuesta = await getRefPago(context,tipodni,usuario.dni,);
          Navigator.of(context).pop();
          if(respuesta!=null){
           prefs.isClient=(respuesta)?true:false;
          }
          else{
            Navigator.of(context).pop();
            _alertFail(context,'Ha ocurrido un error inesperado.');
          }
          //////////////// FIN REFERENCIA DE PAGO //////////////////////////////
          //si el usuario ingresa un dni y se loguea con otra cuenta
          if(usuario.dni.toString().toLowerCase()==prefs.numerodni.toString().toLowerCase() && usuario.tipoDni.toString().toLowerCase()==prefs.tipodni.toString().toLowerCase()){
                prefs.nombres=usuario.nombres.toString();
                Provider.of<ParrillaHomeViewModel>(context, listen:false).nombresUser= usuario.nombres.toString();
          prefs.distrito= usuario.distrito.toString();
          Provider.of<ParrillaHomeViewModel>(context, listen:false).distritoUser = usuario.distrito.toString();
          //Navigator.of(context).pushReplacementNamed('parrillaHome');
          Navigator.of(context).pushNamedAndRemoveUntil('parrillaHome', (Route<dynamic> route) => false);
          }
          else{
            Navigator.of(context).pop();
             _alertFail(context,'Debe estar registrado para acceder, por favor revise el Tipo y Número de documento.');
          }
          
          }
        else{
          Navigator.of(context).pop();
         _alertFail(context,result['mensaje']);
        }
    
      }
      
    }
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
        final response= referenciaPagoFromJson(resp.body);
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
    
  void _alertFail(context, String mensaje) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            title: Text('Autenticación de Usuario'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(mensaje),
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
            title: Text('Iniciando Sesión', style: TextStyle(fontSize: f(20))),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(width: w(10)),
                Text(
                  'Cargando Data...',
                  style: TextStyle(fontSize: f(20)),
                ),
                //FlutterLogo(size:100.0),
              ],
            ),
            actions: <Widget>[
            ],
          );
        });
  }

  Future<Usuario> obtenerMiUsuario() async {

    try{
     var url='https://servicableapp-74e44.firebaseio.com';
    final token = prefs.token;
    final urlObtenerUsuario = '$url/user.json?auth=$token'; 
    final resp = await http.get(urlObtenerUsuario);
    Usuario usuario = new Usuario();
    final Map<String, dynamic> respDecode = json.decode(resp.body);

    if (respDecode == null)
      return null; //si no existe registros en la bd de firestore, va a retornar un null

    if (respDecode['error'] != null)return null; 

    respDecode.forEach((idUsuario, camposUsuario) { //FOREACH USUARIOS
      if (camposUsuario['id'] == prefs.uidUser) {
        prefs.keyUserLog = idUsuario;
        Usuario miUsuario = new Usuario();
        miUsuario.nombres = camposUsuario['nombres'];
        miUsuario.departamento = camposUsuario['departamento'];
        miUsuario.dni= camposUsuario['dni'];
        miUsuario.tipoDni= camposUsuario['tipoDni'];
        miUsuario.distrito= camposUsuario['distrito'];
        miUsuario.id= camposUsuario['id'];
        miUsuario.email= camposUsuario['email'];
        miUsuario.telefono= camposUsuario['telefono'];
        usuario = miUsuario;
      }
    });
    
    this.userLogged= usuario;
    return usuario;
    }
    catch(e){
      return null;
    }
    
  }
}
