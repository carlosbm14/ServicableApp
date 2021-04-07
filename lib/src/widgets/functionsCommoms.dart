import 'dart:io';
import 'package:appservicable/src/models/tipoProductoModel.dart';
import 'package:appservicable/src/settings/colorz.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/widgets/getImageInternetWidget.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:appservicable/src/viewmodels/loginViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

String _phone = "+51965462499";
urlWhatsapp() async {
  String url() {
    if (Platform.isIOS) {
      return "whatsapp://wa.me/$_phone/?text=${Uri.parse('')}";
    } else {
      return "whatsapp://send?phone=$_phone&text=${Uri.parse('')}";
    }
  }

  if (await canLaunch(url())) {
    await launch(url());
  } else {
    throw 'No se puede abrir ${url()}';
  }
}

void alertTryAgain(context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text('Error de Conexión'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Requiere conexión a internet para continuar.'),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('CANCELAR'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<LoginViewModel>(context, listen: false)
                    .reintentar(context);
              },
              child: Text('REINTENTAR'),
            ),
          ],
        );
      });
}

void showDialogSlide(BuildContext context, TipoProducto producto) {
  String descripcionNew = producto.descripcion.replaceAll('.', '\n\n');
  slideDialog.showSlideDialog(
    context: context,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: w(3)),
      child: Stack(
        children: [
        Container( width: w(600), height: w(600), //color: Colors.white ,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getImageInternetWidget(producto.urlImage),
                Text(
                  producto.nombre,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: f(22)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: w(20)),
                Text(
                  descripcionNew,
                  style: TextStyle(color: Colors.black87, fontSize: f(22)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: w(40)),



              ],
            ),
          ),


        Positioned ( bottom: w(1), left: w(345),
                  child: RawMaterialButton(
              onPressed: () {
                final dateTime = DateTime.now();
                int horaActual = dateTime.hour;
                (horaActual >= 18)
                    ? Navigator.pushNamed(context, 'formularioQuieroComprar')
                    : urlWhatsapp();
              },
              elevation: 2.0,
              fillColor: Colorz.appBarBlue,
              child: Center(child: Text('¡Pídelo \n aquí!', style: TextStyle(fontSize: f(22), color: Colors.white, fontWeight: FontWeight.bold ),textAlign: TextAlign.center, )),
              padding: EdgeInsets.all(22.0),
              shape: CircleBorder(),
            ),
        ),


        ],
      ),
    ),
    barrierColor: Colors.white.withOpacity(0.7),
    barrierDismissible: true,
    pillColor: Colors.black,
    backgroundColor: Colorz.slideDialog,
  );
}


   



void validationFail(context, String mensaje) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text('Validación', style: TextStyle(fontSize: f(24))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                mensaje,
                style: TextStyle(fontSize: f(20)),
              ),
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

void alertLoading(context, String title) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text(title, style: TextStyle(fontSize: f(24))),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(width: w(10)),
              Text(
                'Enviando Data...',
                style: TextStyle(fontSize: f(20)),
              ),
            ],
          ),
          actions: <Widget>[],
        );
      });
}

urlFacebook() async {
  const url = "https://fb.me/servicableperu";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No se puede abrir $url';
  }
}

urlInstagram() async {
  const url = "https://www.instagram.com/servicableperu";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No se puede abrir $url';
  }
}

List<DropdownMenuItem<int>> provinciaDropDownList(){
  return [
    DropdownMenuItem(
                  child: Text("Lima", style: TextStyle(fontSize: f(20))),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Callao", style: TextStyle(fontSize: f(20))),
                  value: 2,
                )
  ];
}

List<DropdownMenuItem<int>> departamentoDropDownList(){
  return [
    DropdownMenuItem(
                  child: Text("Lima", style: TextStyle(fontSize: f(20))),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Callao", style: TextStyle(fontSize: f(20))),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: Text("Arequipa", style: TextStyle(fontSize: f(20))),
                  value: 3,
                )
  ];
}

List<DropdownMenuItem<int>> distritosDropDownList(int dto){
  return 
  (dto==1)?[             DropdownMenuItem(
                  child: Text("Cercado de Lima", style: TextStyle(fontSize: f(20))),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Ate", style: TextStyle(fontSize: f(20))),
                  value: 2,
                ),DropdownMenuItem(
                  child: Text("Barranco", style: TextStyle(fontSize: f(20))),
                  value: 3,
                ),DropdownMenuItem(
                  child: Text("Breña", style: TextStyle(fontSize: f(20))),
                  value: 4,
                ),DropdownMenuItem(
                  child: Text("Carabayllo", style: TextStyle(fontSize: f(20))),
                  value: 5,
                ),DropdownMenuItem(
                  child: Text("Comas", style: TextStyle(fontSize: f(20))),
                  value: 6,
                ),DropdownMenuItem(
                  child: Text("Chorrillos", style: TextStyle(fontSize: f(20))),
                  value: 7,
                ),DropdownMenuItem(
                  child: Text("El Agustino", style: TextStyle(fontSize: f(20))),
                  value: 8,
                ),DropdownMenuItem(
                  child: Text("Jesús María", style: TextStyle(fontSize: f(20))),
                  value: 9,
                ),DropdownMenuItem(
                  child: Text("La Molina", style: TextStyle(fontSize: f(20))),
                  value: 10,
                ),DropdownMenuItem(
                  child: Text("La Victoria", style: TextStyle(fontSize: f(20))),
                  value: 11,
                ),DropdownMenuItem(
                  child: Text("Lince", style: TextStyle(fontSize: f(20))),
                  value: 12,
                ),DropdownMenuItem(
                  child: Text("Magdalena del Mar", style: TextStyle(fontSize: f(20))),
                  value: 13,
                ),DropdownMenuItem(
                  child: Text("Miraflores", style: TextStyle(fontSize: f(20))),
                  value: 14,
                ),DropdownMenuItem(
                  child: Text("Pueblo Libre", style: TextStyle(fontSize: f(20))),
                  value: 15,
                ),DropdownMenuItem(
                  child: Text("Puente Piedra", style: TextStyle(fontSize: f(20))),
                  value: 16,
                ),DropdownMenuItem(
                  child: Text("Rimac", style: TextStyle(fontSize: f(20))),
                  value: 17,
                ),DropdownMenuItem(
                  child: Text("San Isidro", style: TextStyle(fontSize: f(20))),
                  value: 18,
                ),DropdownMenuItem(
                  child: Text("Independencia", style: TextStyle(fontSize: f(20))),
                  value: 19,
                ),DropdownMenuItem(
                  child: Text("San Juan de Miraflores", style: TextStyle(fontSize: f(20))),
                  value: 20,
                ),DropdownMenuItem(
                  child: Text("San Luis", style: TextStyle(fontSize: f(20))),
                  value: 21,
                ),DropdownMenuItem(
                  child: Text("San Martin de Porres", style: TextStyle(fontSize: f(20))),
                  value: 22,
                ),DropdownMenuItem(
                  child: Text("San Miguel", style: TextStyle(fontSize: f(20))),
                  value: 23,
                ),DropdownMenuItem(
                  child: Text("Santiago de Surco", style: TextStyle(fontSize: f(20))),
                  value: 24,
                ),DropdownMenuItem(
                  child: Text("Surquillo", style: TextStyle(fontSize: f(20))),
                  value: 25,
                ),DropdownMenuItem(
                  child: Text("Villa María del Triunfo", style: TextStyle(fontSize: f(20))),
                  value: 26,
                ),DropdownMenuItem(
                  child: Text("San Juan de Lurigancho", style: TextStyle(fontSize: f(20))),
                  value: 27,
                ),DropdownMenuItem(
                  child: Text("Santa Rosa", style: TextStyle(fontSize: f(20))),
                  value: 28,
                ),DropdownMenuItem(
                  child: Text("Los Olivos", style: TextStyle(fontSize: f(20))),
                  value: 29,
                ),DropdownMenuItem(
                  child: Text("San Borja", style: TextStyle(fontSize: f(20))),
                  value: 30,
                ),DropdownMenuItem(
                  child: Text("Villa El Savador", style: TextStyle(fontSize: f(20))),
                  value: 31,
                ),DropdownMenuItem(
                  child: Text("Santa Anita", style: TextStyle(fontSize: f(20))),
                  value: 32,
                ),DropdownMenuItem(
                  child: Text("Cieneguilla", style: TextStyle(fontSize: f(20))),
                  value: 33,
                ),
  ]:
  (dto==2)?
  [DropdownMenuItem(
                  child: Text("Callao", style: TextStyle(fontSize: f(20))),
                  value: 1,
                ),DropdownMenuItem(
                  child: Text("La Perla", style: TextStyle(fontSize: f(20))),
                  value: 2,
                ),DropdownMenuItem(
                  child: Text("Bellavista", style: TextStyle(fontSize: f(20))),
                  value: 3,
                ),
                DropdownMenuItem(
                  child: Text("La Punta", style: TextStyle(fontSize: f(20))),
                  value: 4,
                ),
                DropdownMenuItem(
                  child: Text("Carmen de La Legua", style: TextStyle(fontSize: f(20))),
                  value: 5,
                ),
                 DropdownMenuItem(
                  child: Text("Ventanilla", style: TextStyle(fontSize: f(20))),
                  value: 6,
                )]:
                (dto==3)?
                [
                  DropdownMenuItem(
                  child: Text("Alto Selva Alegre", style: TextStyle(fontSize: f(20))),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Arequipa", style: TextStyle(fontSize: f(20))),
                  value: 2,
                ),DropdownMenuItem(
                  child: Text("Cayma", style: TextStyle(fontSize: f(20))),
                  value: 3,
                ),DropdownMenuItem(
                  child: Text("Cerro Colorado", style: TextStyle(fontSize: f(20))),
                  value: 4,
                ),DropdownMenuItem(
                  child: Text("Characato", style: TextStyle(fontSize: f(20))),
                  value: 5,
                ),DropdownMenuItem(
                  child: Text("Chiguata", style: TextStyle(fontSize: f(20))),
                  value: 6,
                ),DropdownMenuItem(
                  child: Text("Jacobo Hunter", style: TextStyle(fontSize: f(20))),
                  value: 7,
                ),DropdownMenuItem(
                  child: Text("José Luis Bustamante y Rivero", style: TextStyle(fontSize: f(20))),
                  value: 8,
                ),DropdownMenuItem(
                  child: Text("La Joya", style: TextStyle(fontSize: f(20))),
                  value: 9,
                ),DropdownMenuItem(
                  child: Text("Mariano Melgar", style: TextStyle(fontSize: f(20))),
                  value: 10,
                ),DropdownMenuItem(
                  child: Text("Miraflores", style: TextStyle(fontSize: f(20))),
                  value: 11,
                ),DropdownMenuItem(
                  child: Text("Mollebaya", style: TextStyle(fontSize: f(20))),
                  value: 12,
                ),DropdownMenuItem(
                  child: Text("Paucarpata", style: TextStyle(fontSize: f(20))),
                  value: 13,
                ),DropdownMenuItem(
                  child: Text("Pocsi", style: TextStyle(fontSize: f(20))),
                  value: 14,
                ),DropdownMenuItem(
                  child: Text("Polobaya", style: TextStyle(fontSize: f(20))),
                  value: 15,
                ),DropdownMenuItem(
                  child: Text("Quequeña", style: TextStyle(fontSize: f(20))),
                  value: 16,
                ),DropdownMenuItem(
                  child: Text("Sabandía", style: TextStyle(fontSize: f(20))),
                  value: 17,
                ),DropdownMenuItem(
                  child: Text("Sachaca", style: TextStyle(fontSize: f(20))),
                  value: 18,
                ),DropdownMenuItem(
                  child: Text("San Juan de Siguas", style: TextStyle(fontSize: f(20))),
                  value: 19,
                ),DropdownMenuItem(
                  child: Text("San Juan de Tarucani", style: TextStyle(fontSize: f(20))),
                  value: 20,
                ),DropdownMenuItem(
                  child: Text("Santa Isabel de Siguas", style: TextStyle(fontSize: f(20))),
                  value: 21,
                ),DropdownMenuItem(
                  child: Text("Santa Rita de Siguas", style: TextStyle(fontSize: f(20))),
                  value: 22,
                ),DropdownMenuItem(
                  child: Text("Socabaya", style: TextStyle(fontSize: f(20))),
                  value: 23,
                ),DropdownMenuItem(
                  child: Text("Tiabaya", style: TextStyle(fontSize: f(20))),
                  value: 24,
                ),DropdownMenuItem(
                  child: Text("Uchumayo", style: TextStyle(fontSize: f(20))),
                  value: 25,
                ),DropdownMenuItem(
                  child: Text("Vitor", style: TextStyle(fontSize: f(20))),
                  value: 26,
                ),DropdownMenuItem(
                  child: Text("Yanahuara", style: TextStyle(fontSize: f(20))),
                  value: 27,
                ),DropdownMenuItem(
                  child: Text("Yarabamba", style: TextStyle(fontSize: f(20))),
                  value: 28,
                ),
                DropdownMenuItem(
                  child: Text("Yura", style: TextStyle(fontSize: f(20))),
                  value: 29,
                ),
                ]:
                [];
}