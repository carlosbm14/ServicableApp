import 'dart:convert';
import 'package:appservicable/src/viewmodels/dniViewModel.dart';
import 'package:appservicable/src/models/usuarioModel.dart';
import 'package:appservicable/src/settings/persistence.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/parrillaHomeViewModel.dart';
import 'package:appservicable/src/viewmodels/loginViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class RegistroViewModel extends ChangeNotifier {
  final prefs = new PersistenceLocal();
  bool _isLoading = false;

  get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    this._isLoading = value;
    notifyListeners();
  }

  Future<void> registrarButtonPressed(
    BuildContext context, {
    String pass,
    String dpto,
    String nombres,
    String dtrto,
    String email,
    String telefono,
    String dni,
    String tipoDni
  }) async {
    if (dpto == "" ||
        pass == "" ||
        nombres == "" ||
        dtrto == "" ||
        email == "" ||
        telefono == "" ||
        dni == "" ||
        tipoDni == "") {
      _alertFail(context,
          'Todos los campos son obligatorios. Por favor complete el formulario.');
    } else if (!validateEmail(email)) {
      _alertFail(context,
          'Existe un error con su correo. Por favor ingrese un email válido.');
    } 
    else if (pass.length<6) {
      _alertFail(context,
          'Contraseña débil. Su contraseña debe contener al menos 6 caracteres.');
    }
    else {
      _alertLoading(context);
      final tieneCuenta = await existeUsuario(context);
      if(tieneCuenta!=null){
           if(tieneCuenta){
             Navigator.of(context).pop();
             Toast.show(
          'Usted ya posee una cuenta registrada.',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.black.withOpacity(0.85),
        );
           }
           else{
             //hago el registro
              Map<String, dynamic> result = await registrarUsuarioAuth(
        context,
        email,
        pass,
        dni: dni,
        distrito: dtrto,
        departamento: dpto,
        nombres: nombres,
        tipoDni: tipoDni,
        telefono: telefono,
      ); 

      
      
      if (result['ok']){ 
        prefs.email=email;
        prefs.password=pass;
        prefs.tipodni= tipoDni;
        prefs.numerodni= dni;
        prefs.distrito=dtrto;
        prefs.nombres=nombres;
        Provider.of<ParrillaHomeViewModel>(context, listen: false).nombresUser=nombres;
        Provider.of<ParrillaHomeViewModel>(context, listen: false).distritoUser=dtrto;
        var tipodni=(tipoDni=='DNI')?'1':
       (tipoDni=='CEDULA')?'2':
       (tipoDni=='CARNET DE EXTRANJERIA')?'3':
       (tipoDni=='RUC')?'4':
        (tipoDni=='PASAPORTE')?'5':
       (tipoDni=='PTP')?'6':
       '1';
        final respuesta = await Provider.of<LoginViewModel>(context, listen: false).getRefPago(context,tipodni,dni);
         Navigator.of(context).pop();
          if(respuesta!=null){
           prefs.isClient=(respuesta)?true:false;
          }
        Navigator.of(context).pushNamedAndRemoveUntil('parrillaHome', (Route<dynamic> route) => false);

        
        }
      else{
        String mssg= (result['mensaje'].toString().startsWith("EMAIL_EXISTS"))?'El Correo ingresado ya existe en la Base de Datos.':'Ha ocurrido un error inesperado.';
        
        Toast.show(
          mssg,
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.black.withOpacity(0.85),
        );
      }
           }

      }
      else{
        Navigator.of(context).pop();
        Toast.show(
          'Ha ocurrido un error, revise su conexión a internet y vuelva a intentarlo.',
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.black.withOpacity(0.85),
        );
      }
     
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
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
            title: Text('Registro de Usuario'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(mensaje),
                //FlutterLogo(size:100.0),
              ],
            ),
            actions: <Widget>[
              /*FlatButton(
              onPressed: ()=>Navigator.of(context).pop(), 
              child: Text('Cancelar'),
            ),*/
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

  final String _firebaseToken = 'AIzaSyBxkKITktwuMtVIfKYkdE9BcrC147vg1k0';

  Future<bool> existeUsuario(BuildContext context) async {

    try{
     var url='https://servicableapp-74e44.firebaseio.com';
    final urlObtenerUsuario = '$url/user.json';//?auth=$token'; 
    final resp = await http.get(urlObtenerUsuario);
    final Map<String, dynamic> respDecode = json.decode(resp.body);

    if (respDecode == null)
      return false; //si no existe registros en la bd de firestore, va a retornar un null
     final vm= Provider.of<DniViewModel>(context, listen:false);
    if (respDecode['error'] != null)return null;
    bool retorno=false;
    respDecode.forEach((idUsuario, camposUsuario) { //FOREACH USUARIOS
      if (camposUsuario['dni'] == vm.dni && camposUsuario['tipoDni'] == vm.tipodni) {
         retorno= true; //ya ese dni y tipodni tienen una cuenta
      }
    });

    return retorno;
    }
    catch(e){
      return null;
    }
    
  }

  Future<Map<String, dynamic>> registrarUsuarioAuth(
    BuildContext context,
    String email,
    String password, {
    String dni,
    String departamento,
    String distrito,
    String nombres,
    String referencia,
    String telefono,
    String tipoDni,
  }) async {
    try {
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
        Map<String, dynamic> result = await _crearUsuario(
          context,
          decodedResp['localId'],
          email,
          dni: dni,
          departamento: departamento,
          distrito: distrito,
          referencia: referencia,
          telefono: telefono,
          nombres: nombres,
          tipoDni: tipoDni,
        ); //aqui le paso el id del usuario
        prefs.uidUser = decodedResp['localId'];
        return result;
      } else {
        
        return {'ok': false, 'mensaje': decodedResp['error']['message']};
      }
    } catch (e) {
      
      return {'ok': false, 'mensaje': e};
    }
  }

  Future<Map<String, dynamic>> _crearUsuario(
    BuildContext context,
    String idUsuario,
    String email, {
    String dni,
    String departamento,
    String distrito,
    String nombres,
    String referencia,
    String telefono,
    String tipoDni,
  }) async {
    try {
      final String _url = 'https://servicableapp-74e44.firebaseio.com';
      final urlCrearUsuario =
          '$_url/user.json?auth=${prefs.token}'; //aqui inserto la url restante de productos (en firebase) y le agrego el .json ajuro
      Usuario usuario = new Usuario();
      usuario.id = idUsuario;
      usuario.email = email;
      usuario.departamento = departamento;
      usuario.distrito = distrito;
      usuario.telefono = telefono;
      usuario.referencia = referencia;
      usuario.nombres = nombres;
      usuario.dni= dni;
      usuario.tipoDni= tipoDni;
      
      final resp =  await http.post(urlCrearUsuario, body: json.encode(usuario.toJson()));
      final respDecode = json.decode(resp
          .body);
      if (respDecode.containsKey('error')) {
        return {'ok': false, 'mensaje': 'Ha ocurrido un error inesperado.'};
      }
      else{
              prefs.keyUserLog =
          respDecode['name']; //aqui guardo la key principal de mi usuario
     // prefs.isClient=(cliente==1)?true:false; //1 cliente, 2 invitado
          prefs.tipodni= usuario.tipoDni;
          prefs.numerodni= usuario.dni;
          prefs.email= usuario.email;
          prefs.distrito= usuario.distrito;
          prefs.nombres= usuario.nombres;
          prefs.telefono= usuario.telefono;
          prefs.departamento= usuario.departamento;
      return {'ok': true, 'mensaje': 'good'};
      }
      
    } catch (e) {
      
      return {'ok': false, 'mensaje': e};
    }
  }


  

}
