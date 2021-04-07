import 'package:appservicable/src/models/backgroundModel.dart';
import 'package:appservicable/src/settings/persistence.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/loginViewModel.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/widgets/buttonSend.dart';
import 'package:appservicable/src/widgets/functionsCommoms.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final prefs = new PersistenceLocal();
  TextEditingController _inputPassContoller = new TextEditingController();
  TextEditingController _inputUserContoller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    ScreenUtil.init(context,
        width: SizesCustom.width,
        height: SizesCustom.height,
        allowFontScaling: true);
    final _screenLocal = MediaQuery.of(context).size;
    final _screenLocalH = _screenLocal.height;
    final _screenLocalW = _screenLocal.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        Consumer<PromosViewModel>(builder: (context, model, _) {

          final List<Background> promos = model.imagenesBackgrounds;
    var foto;
    if (promos.length > 0) {
      foto = promos.where((i) => i.nombre == 'login').first;
    }
          return Container(
          constraints: BoxConstraints.expand(),
          decoration: (foto!=null)?BoxDecoration(
            
            image: DecorationImage(
                fit: BoxFit.fill,
                image: CachedNetworkImageProvider(foto.urlImage)),
          ): BoxDecoration(),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: w(40.0)),
            children: <Widget>[
              SizedBox(height: h(30),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w(50), vertical: w(0)),
                child: _logoServicable(),
              ),
              SizedBox(
                height: _screenLocalH * 0.04,
              ),
              Center(
                child: Container(
                  height: _screenLocalH * 0.63,
                  child: ListView(
                    children: <Widget>[
                      //_crearSwitch(),
                      SizedBox(
                        height: _screenLocalH * 0.03,
                      ),
                      _createInputs(
                        _inputUserContoller,
                        'Email',
                        TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: h(8),
                      ),
                      _createInputs(
                          _inputPassContoller, 'Contraseña', TextInputType.text,
                          pass: 'Password'),
                      SizedBox(
                        height: _screenLocalH * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w(50), vertical: w(0)),
                        child: sendButton(() {
                          Provider.of<LoginViewModel>(context, listen: false)
                              .loginButtonPressed(
                            context,
                            _inputPassContoller.text,
                            _inputUserContoller.text,
                            (prefs.isClient) ? true : false,
                          );
                        }, titleText: 'Login'),
                      ),
                      SizedBox(
                        height: _screenLocalH * 0.05,
                      ),
                      _textoContrasena(_screenLocalH),
                      SizedBox(
                        height: _screenLocalH * 0.02,
                      ),

                      _textoRegistro(_screenLocalH),
                      SizedBox(
                        height: _screenLocalH * 0.2,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: _screenLocalH * 0.027,
              ),
              _cintaLogos(_screenLocalW),
            ],
          ),
        );})
      ]),
    );
  }

  Widget _logoServicable() {
    return Image(
      image: AssetImage("assets/images/logos/newLogoServi.png"),
    );
  }

  Widget _createInputs(TextEditingController controller, String titulo,
      TextInputType tipoTeclado,
      {String pass}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(60), vertical: w(5)),
      child: Column(
        children: [
          Align(
              alignment: Alignment.bottomLeft,
              child:
                  Text(titulo, style: TextStyle(fontWeight: FontWeight.bold))),
          TextField(
            controller: controller,
            keyboardType: tipoTeclado,
            obscureText: (pass == null) ? false : true,
            style: TextStyle(
              height: 1,
            ),
            cursorColor: Colors.blue,
          ),
        ],
      ),
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
          onTap: () async {
            Provider.of<LoginViewModel>(context, listen: false)
                .loginButtonPressed(
              context,
              _inputPassContoller.text,
              _inputUserContoller.text,
              (prefs.isClient) ? true : false,
            );
          },
          child: Center(
            child: Text(
              'LOGIN',
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

  Widget _textoContrasena(_screenLocalH) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'recuperar');
        },
        child: Text(
          'Olvidé mi contraseña',
          style: TextStyle(
            color: Colors.blueAccent,
            decoration: TextDecoration.underline,
            fontSize: _screenLocalH * 0.023,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _textoRegistro(_screenLocalH) {
    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'registro');
        },
        child: Text(
          'Registrarme en Servicable',
          style: TextStyle(
            color: Colors.blueAccent,
            decoration: TextDecoration.underline,
            fontSize: _screenLocalH * 0.023,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _cintaLogos(_screenLocalW) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => urlWhatsapp(),
              child: Image(
                width: _screenLocalW * 0.10,
                image: AssetImage("assets/images/logos/whatsappw.png"),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 30.0,
        ),
        Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => urlFacebook(),
              child: Image(
                width: _screenLocalW * 0.09,
                image: AssetImage("assets/images/logos/facebookw.png"),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 30.0,
        ),
        Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => urlInstagram(),
              child: Image(
                width: _screenLocalW * 0.09,
                image: AssetImage("assets/images/logos/instagramw.png"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _urlPhone() async {
    const url = "tel:+51936537556";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se puede abrir $url';
    }
  }

  _urlMail() async {
    const url = "mailto:viveconectado@servicable.com.pe";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se puede abrir $url';
    }
  }
}
