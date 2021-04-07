import 'package:appservicable/src/models/promoModel.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/widgets/functionsCommoms.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appservicable/src/settings/colorz.dart';
import 'package:appservicable/src/models/backgroundModel.dart';

class InternetWidget extends StatefulWidget {
  @override
  _InternetWidgetState createState() => _InternetWidgetState();
}

class _InternetWidgetState extends State<InternetWidget> {
  @override
  Widget build(BuildContext context) {
                var promos= Provider.of<PromosViewModel>(context, listen:false).imagenesBackgrounds;
         Background foto;
         if(promos.length>0){
            foto =  promos.where((i) => i.nombre=='solicitud_internet').first;
         }
         else{
           Provider.of<PromosViewModel>(context, listen:false).obtenerBackgrounds();
            foto=  null;
         }
         
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
    
      floatingActionButton: Container(
                        width: w(100),
                        height: w(100),
                        child: FloatingActionButton(
         isExtended: true,

        child: Center(child: Text('¡Pídelo aquí!', style: TextStyle(fontSize: f(22)), textAlign: TextAlign.center,)),
        backgroundColor: Colorz.appBarBlue,
        onPressed: () {
          final dateTime= DateTime.now();
          int horaActual= dateTime.hour;
          (horaActual>=18)?
          Navigator.pushNamed(context, 'formularioQuieroComprar'):
          urlWhatsapp();
        }
      ),
                      ),

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
    );
  }
}