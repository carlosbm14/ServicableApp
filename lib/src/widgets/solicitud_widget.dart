import 'package:appservicable/src/models/backgroundModel.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'functionsCommoms.dart';

class SolicitudWidget extends StatefulWidget {
  @override
  _SolicitudWidgetState createState() => _SolicitudWidgetState();
}
//78e8c2, 7bc7d5, fbb0aa
class _SolicitudWidgetState extends State<SolicitudWidget> {
  @override
  Widget build(BuildContext context) {
     var promos= Provider.of<PromosViewModel>(context, listen:false).imagenesBackgrounds;
         Background foto;
         if(promos.length>0){
            foto =  promos.where((i) => i.nombre=='solicitud_servicio').first;
         }
         else{
           Provider.of<PromosViewModel>(context, listen:false).obtenerBackgrounds();
            foto=  null;
         }
    final _screenHeight = MediaQuery.of(context).size.height;
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
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
           Positioned(
          top: w(40),
          right: w(0),
          child: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, size: w(40),color: Colors.white),),
        )
        ],
      ),
      floatingActionButton: _buttonsList(_screenHeight, _screenWidth),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
    );
  }
   
  Widget _buttonsList(_screenHeight, _screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
           Navigator.pushNamed(context, 'formularioAmentodeMegas');
          },
          child: Card(
            color: Color.fromRGBO(120, 232, 194, 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0,),
              child: Container(
                width: _screenWidth*0.28,
                height: _screenHeight*0.13,
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          height: _screenHeight*0.07,
                          image: AssetImage("assets/images/iconos/velocidad.png"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:'Aumento de Megas',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: _screenHeight*0.02,
                              ),
                            ),
                          ), 
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, 'formularioServTecnico');
          },
          child: Card(
            color: Color.fromRGBO(123, 199, 213, 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0,),
              child: Container(
                width: _screenWidth*0.28,
                height: _screenHeight*0.13,
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          height: _screenHeight*0.07,
                          image: AssetImage("assets/images/iconos/configuraciones.png"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:'Servicio Técnico',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: _screenHeight*0.02,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (){
           urlWhatsapp();
          },
          child: Card(
            color: Color.fromRGBO(251, 176, 170, 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0,),
              child: Container(
                width: _screenWidth*0.28,
                height: _screenHeight*0.13,
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          height: _screenHeight*0.07,
                          width: _screenHeight*0.11,
                          image: AssetImage("assets/images/iconos/boton_doble.png"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:'Cambio de Plan',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: _screenHeight*0.02,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}