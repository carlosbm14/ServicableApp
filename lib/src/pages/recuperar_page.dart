import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class RecuperarPage extends StatefulWidget {
  @override
  _RecuperarPageState createState() => _RecuperarPageState();
}

class _RecuperarPageState extends State<RecuperarPage> {
  String _email = '';
  TextEditingController _inputEmailContoller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _screenLocal = MediaQuery.of(context).size;
    final _screenLocalH = _screenLocal.height;
    //final _screenLocalW = _screenLocal.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Recuperar Contraseña',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage("assets/images/backgrounds/login.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
            children: <Widget>[
              _logoServicable(),
              SizedBox(
                height: _screenLocalH * 0.14,
              ),
              Center(
                child: Container(
                  height: _screenLocalH * 0.55,
                  child: Column(
                    children: <Widget>[
                      _crearInputUsername(_screenLocalH),
                      SizedBox(
                        height: _screenLocalH * 0.07,
                      ),
                      _createSendButton(_screenLocalH),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
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
            title: Text('Recuperación de Contraseña'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(mensaje, style: TextStyle(fontSize: f(20))),
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

  _sendData() async {
    try {
      if (_email == "") {
        _alertFail(context, 'Debe ingresar un correo electrónico.');
      } else {
        _alertLoading(context);
        final String _firebaseToken = 'AIzaSyBxkKITktwuMtVIfKYkdE9BcrC147vg1k0';

        final url =
            "https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$_firebaseToken";
        final authData = {"requestType": "PASSWORD_RESET", "email": "$_email"};
        final body = json.encode(authData);
        final resp = await http.post(url, body: body);
        Map<String, dynamic> decodedResp = json.decode(resp.body);
        Navigator.pop(context);
        if (decodedResp.containsKey('error')) {
          String mensaje = (decodedResp["error"]["message"] ==
                  'EMAIL_NOT_FOUND')
              ? 'No hay registro de usuario correspondiente a este email. Es posible que se haya eliminado al usuario o el email ingresado esté incorrecto.'
              : 'Ha ocurrido un error inesperado. Revise el Email ingresado y vuelva a intentarlo.';
          _alertFail(context, mensaje);
        } else {
          _alertFail(context,
              'Se ha enviado un enlace a su dirección de correo electrónico. Por favor acceda a su cuenta email para recuperar contraseña.');
        }
      }
    } catch (e) {
      _alertFail(context,
          'Ha ocurrido un error inesperado. Revise el Email ingresado y vuelva a intentarlo.');
    }
  }

  Widget _logoServicable() {
    return Image(
      image: AssetImage("assets/images/logos/color_logo.png"),
    );
  }

  Widget _crearInputUsername(_screenLocalH) {
    return TextField(
      controller: _inputEmailContoller,
      style: TextStyle(
        height: _screenLocalH * 0.0015,
      ),
      cursorColor: Colors.blueGrey,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.transparent)),
        fillColor: Color.fromRGBO(216, 217, 217, 1),
        filled: true,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        labelText: 'Email',
        prefixIcon: Icon(
          Icons.email,
          color: Colors.black38,
        ),
      ),
      onChanged: (valor) => setState(() {
        _email = valor;
      }),
    );
  }

  Widget _createSendButton(_screenLocalH) {
    return Container(
      height: _screenLocalH * 0.06,
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white)),
        shadowColor: Color.fromRGBO(206, 207, 207, 1),
        color: Colors.blue[900],
        elevation: 7.0,
        child: InkWell(
          onTap: () {
            _sendData();
          },
          child: Center(
            child: Text(
              'ENVIAR',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: _screenLocalH * 0.03,
              ),
            ),
          ),
        ),
      ),
    );
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
            title:
                Text('Recuperar Contraseña', style: TextStyle(fontSize: f(20))),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(width: w(10)),
                Text(
                  'Enviando Data...',
                  style: TextStyle(fontSize: f(20)),
                ),
                //FlutterLogo(size:100.0),
              ],
            ),
            actions: <Widget>[],
          );
        });
  }
}
