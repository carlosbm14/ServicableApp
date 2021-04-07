import 'package:appservicable/src/models/backgroundModel.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/smtp/server_smtp.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/widgets/buttonSend.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:provider/provider.dart';

import 'functionsCommoms.dart';

class ContactoWidget extends StatefulWidget {
  @override
  _ContactoWidgetState createState() => _ContactoWidgetState();
}

class _ContactoWidgetState extends State<ContactoWidget> {
  String _name = '';
  String _telephone = '';
  String _text = '';
  String _email = '';
  TextEditingController _inputNameContoller = new TextEditingController();
  TextEditingController _inputPhoneContoller = new TextEditingController();
  TextEditingController _inputTextContoller = new TextEditingController();
  TextEditingController _inputEmailContoller = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {

var promos= Provider.of<PromosViewModel>(context, listen:false).imagenesBackgrounds;
         Background foto;
         if(promos.length>0){
            foto =  promos.where((i) => i.nombre=='contactos').first;
         }
         else{
           Provider.of<PromosViewModel>(context, listen:false).obtenerBackgrounds();
            foto=  null;
         }

    final _screenLocal = MediaQuery.of(context).size;
    final _screenLocalH = _screenLocal.height;
    final _screenLocalW = _screenLocal.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: sendButton( (){
        _sendingMail();
      }),
      body: Stack(
        children: <Widget>[
         Container(
            constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgrounds/login.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.fill,
        imageUrl: (foto==null)?'':foto.urlImage,
        progressIndicatorBuilder: (context, url, downloadProgress) => 
                Center(
                  child: Container(
                    width: w(100),
                    height: w(100),
                    child: CircularProgressIndicator(value: downloadProgress.progress,)),
                ),
        errorWidget: (context, url, error) {
          
          return Container(
            color: Colors.black.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(Icons.portable_wifi_off, size: w(120), color: Colors.white),
                 Text('No posee conexión a Internet...', style: TextStyle(color: Colors.white, fontSize: f(25)),)
               ],
             ),
          );
        }
     )

          ),
             ListView(
              padding: EdgeInsets.only(top: _screenLocalH*0.29, left: 49.0, right: 49.0),//EdgeInsets.symmetric(horizontal: 50.0, vertical: _screenLocalH*0.44),
              children: <Widget>[
                Center(
                  child: Container(
                    height: _screenLocalH*0.55,
                    child: Column(
                      children: <Widget>[
                        _crearInputName(_screenLocalH),
                        SizedBox(height: _screenLocalH*0.005,),
                        _crearInputEmail(_screenLocalH),
                        SizedBox(height: _screenLocalH*0.005,),
                        _createInputPhone(_screenLocalH),
                        //SizedBox(height: _screenLocalH*0.02,),
                        SizedBox(height: 12.5,),
                        _createInputDescrip(_screenLocalH),
                        //SizedBox(height: _screenLocalH*0.0754,),
                        //_createSendButton(_screenLocalH,_screenLocalW),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: _screenLocalH*0.04,left: _screenLocalW*0.58),
                color: Colors.transparent,
                width: _screenLocalH*0.1,
                height: _screenLocalW*0.18,
                child: InkWell(
                  onTap: () => urlWhatsapp(),
                  child: Text(''),
                ),
              ),
            ],
          ),
          Positioned(
          top: w(40),
          right: w(0),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, size: w(40), color: Colors.blue),),
        )
        ]
      ),
    );
  }

  

  Widget _crearInputName(_screenLocalH) {
    return TextField(
      controller: _inputNameContoller,
      style: TextStyle(height: _screenLocalH*0.0009,),
      cursorColor: Colors.blueGrey,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          //borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color:Colors.black)
        ),
        focusedBorder: UnderlineInputBorder(
          //borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color:Colors.black),
        ),
        fillColor: Colors.white,
        filled: true,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        labelText: 'Nombres y apellidos',
        prefixIcon: Icon(Icons.account_circle,color: Colors.black38,),
      ),
      onChanged: (valor) => setState(() {
        _name = valor;
      }),
    );
  }

  Widget _crearInputEmail(_screenLocalH) {
    return TextField(
      controller: _inputEmailContoller,
      keyboardType: TextInputType.emailAddress,
      //style: TextStyle(height: _screenLocalH*0.0008,),
      cursorColor: Colors.blueGrey,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          //borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color:Colors.black)
        ),
        focusedBorder: UnderlineInputBorder(
          //borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color:Colors.black),
        ),
        fillColor: Colors.white,
        filled: true,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        labelText: 'Correo',
        prefixIcon: Icon(Icons.mail,color: Colors.black38,),
      ),
      onChanged: (valor) => setState(() {
        _email = valor;
      }),
    );
  }

  Widget _createInputPhone(_screenLocalH) {
    return TextField(
      controller: _inputPhoneContoller,
      keyboardType: TextInputType.phone,
      style: TextStyle(height: _screenLocalH*0.0009,),
      cursorColor: Colors.blueGrey,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          //borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color:Colors.black)
        ),
        focusedBorder: UnderlineInputBorder(
          //borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color:Colors.black)
        ),
        fillColor: Colors.white,
        filled: true,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        labelText: 'N° Teléfono',
        prefixIcon: Icon(Icons.phone_android,color: Colors.black38,),
      ),
      onChanged: (valor) => setState(() {
        _telephone = valor;
      }),
    );
  }

  Widget _createInputDescrip(_screenLocalH) {
    return TextField(
      controller: _inputTextContoller,
      keyboardType: TextInputType.text,
      maxLines: 3,
      cursorColor: Colors.blueGrey,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color:Colors.transparent)
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color:Colors.transparent)
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: 'Comentario...',
      ),
      onChanged: (valor) => setState(() {
        _text = valor;
      }),
    );
  }
  
  void _sendingMail() async {
    final smtpServer = configMail();
    final message = Message()
    ..from = Address('clientes@servicable.com.pe','App Servicable')
    ..recipients.addAll(['clientes@servicable.com.pe'])
    ..subject = 'Mensaje de App Servicable :: ${DateTime.now()}'
    ..text = _inputTextContoller.text
    ..html = "<h1>Servicable App</h1>\n<p>Nombres y Apellidos: $_name</p>\n<p>Email: $_email</p>\n<p>Teléfono: $_telephone</p>\n<p>Comentario: $_text</p>";

    if(_name=="" || _telephone == "" || _text == "" || _email == "") {
      _alertFail(context);
    }
    else {
      try {

        alertLoading(context, 'Contacto');
         await send(message, smtpServer);
        Navigator.pop(context);
        _mostrarAlert(context,1);
      } on MailerException catch (e) {
        print(e);
        Navigator.pop(context);
        _mostrarAlert(context,2);
      }
    }
  }
  
  void _alertFail(context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text('Contacto', style: TextStyle(fontSize: f(24))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Error al enviar. Existen campos vacíos.'),
            ],
          ),
          actions: <Widget>[
            
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('ACEPTAR'),
            ),
          ],
        );
      }
    );
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
          title: Text('Contacto', style: TextStyle(fontSize: f(24))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              flag==1?Text('Su comentario ha sido enviado.'):Text('Ha ocurrido un error.'),
              //FlutterLogo(size:100.0),
            ],
          ),
          actions: <Widget>[
           
            FlatButton(
              onPressed: (){
                setState(() {
                  _name = "";
                  _telephone = "";
                  _text = "";
                  _email = "";
                  _inputNameContoller.text = '';
                  _inputPhoneContoller.text = '';
                  _inputTextContoller.text = '';
                  _inputEmailContoller.text = '';
                });
                Navigator.of(context).pop();
              }, 
              child: Text('ACEPTAR'),
            ),
          ],
        );
      }
    );
  }
}