import 'package:appservicable/src/settings/colorz.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/widgets/functionsCommoms.dart';
import 'package:flutter/material.dart';
import 'package:appservicable/src/widgets/card_initial_widget.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final screenHeightCard = _screenSize.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
              child: _buttonInit(context))
        ],
        backgroundColor: Colorz.appBarBlue,
        automaticallyImplyLeading: false,

      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/backgrounds/backgroundCarrusel.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: <Widget>[
                // _buttonLogin(context, _screenHeight),
                SizedBox(height: w(100)),
                _swiperCards(screenHeightCard),
                SizedBox(height: w(130)),
                Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     Container(
                       height: w(150),
                       width: w(200),
                       child: _siguenosButtom(context)),
                   
                    Container(
                      width: w(200),
                      height: w(150),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                           _facebookButtom(context),
                          _instagramButtom(context),
                         
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 Widget _buttonInit(BuildContext context) {
    return Container(
      height: w(80),
      width: w(130),
      margin: EdgeInsets.symmetric(horizontal: w(10), vertical: w(10.0)),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        shadowColor: Colors.blueAccent,
        color: Colors.white,
        elevation: 2.0,
        child: InkWell(
          onTap: () async{
            Navigator.of(context).pushNamedAndRemoveUntil(
                  'login', (Route<dynamic> route) => false);
          },
          child: Center(
            child: Text(
              'Iniciar sesión',
              style: TextStyle(
                color: Color.fromRGBO(9, 88, 145, 1),
                fontWeight: FontWeight.bold,
                fontSize: f(18.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _facebookButtom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: w(0), left: w(0), top: w(0)),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                urlFacebook();
              },
              child: new RotationTransition(
                turns: new AlwaysStoppedAnimation(-2 / 360),
                child: Container(
                  height: w(50),
                  width: w(195.0),
                  padding: EdgeInsets.symmetric(
                      horizontal: w(5.0), vertical: w(13.0)),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/iconos/face2.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Text(''),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _instagramButtom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: w(0), left: w(0), top: w(0)),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                urlInstagram();
              },
              child: new RotationTransition(
                turns: new AlwaysStoppedAnimation(2 / 360),
                child: Container(
                  height: w(50),
                  width: w(195.0),
                  padding: EdgeInsets.symmetric(
                      horizontal: w(5.0), vertical: w(13.0)),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/iconos/insta2.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Text(''),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _siguenosButtom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: w(0), left: w(0), top: w(0)),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                
              },
              child: Container(
                height: w(160),
                width: w(300.0),
                padding:
                    EdgeInsets.symmetric(horizontal: w(0), vertical: w(0)),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/iconos/siguenos5.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Text(''),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _swiperCards(screenHeightCard) {
    return CardSwiper(
        promociones: [1, 2, 3, 4, 5], heightCard: screenHeightCard);
  }
}
