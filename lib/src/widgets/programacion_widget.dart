import 'package:appservicable/src/models/backgroundModel.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/programacionViewModel.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appservicable/src/models/programacionModel.dart';


class ProgramacionWidget extends StatefulWidget {
  @override
  _ProgramacionWidgetState createState() => _ProgramacionWidgetState();
}

class _ProgramacionWidgetState extends State<ProgramacionWidget> {
  @override
  Widget build(BuildContext context) {

 var promos= Provider.of<PromosViewModel>(context, listen:false).imagenesBackgrounds;
         Background foto;
         if(promos.length>0){
            foto =  promos.where((i) => i.nombre=='programacion').first;
         }
         else{
           Provider.of<PromosViewModel>(context, listen:false).obtenerBackgrounds();
            foto=  null;
         }

    final vmPrograma =
        Provider.of<ProgramacionViewModel>(context, listen: false);
    List<Programacion> imagenesCanales = vmPrograma.imagenesCanales;
    int nacional = imagenesCanales
        .where((i) => i.categoria == 'nacionales')
        .toList()
        .length;
    int deportes =
        imagenesCanales.where((i) => i.categoria == 'deportes').toList().length;
    int series = imagenesCanales
        .where((i) => i.categoria == 'series_peliculas')
        .toList()
        .length;
    int documentales = imagenesCanales
        .where((i) => i.categoria == 'documentales')
        .toList()
        .length;
    int infantil =
        imagenesCanales.where((i) => i.categoria == 'infantil').toList().length;
    int noticias = imagenesCanales
        .where((i) => i.categoria == 'noticias_religioso')
        .toList()
        .length;
    int telenovelas = imagenesCanales
        .where((i) => i.categoria == 'telenovelas_musicales')
        .toList()
        .length;
    int variados =
        imagenesCanales.where((i) => i.categoria == 'variados').toList().length;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
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
         Padding(
            padding: EdgeInsets.only(top: w(180.0), left: w(30.0), right: w(30.0)),
            child: ListView(
              children: [
                (nacional > 0)
                    ? _crearBotonPrograma('NACIONAL', Icons.flag)
                    : Offstage(),
                (deportes > 0)
                    ? _crearBotonPrograma('DEPORTES', Icons.directions_run)
                    : Offstage(),
                (series > 0)
                    ? _crearBotonPrograma('SERIES Y PELICULAS', Icons.movie)
                    : Offstage(),
                (documentales > 0)
                    ? _crearBotonPrograma('DOCUMENTALES', Icons.border_color)
                    : Offstage(),
                (infantil > 0)
                    ? _crearBotonPrograma('INFANTIL', Icons.child_care)
                    : Offstage(),
                (noticias > 0)
                    ? _crearBotonPrograma(
                        'NOTICIAS Y RELIGIOSO', Icons.border_inner)
                    : Offstage(),
                (telenovelas > 0)
                    ? _crearBotonPrograma(
                        'TELENOVELAS Y MUSICALES', Icons.library_music)
                    : Offstage(),
                (variados > 0)
                    ? _crearBotonPrograma('VARIADOS', Icons.view_list)
                    : Offstage(),
              ],
            ),
          ),
        
        Positioned(
          top: w(40),
          right: w(0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, size: w(40), color: Colors.white),
          ),
        )
      ]),
    );
  }

  _crearBotonPrograma(String title, IconData icon) {
    return Card(
      color: Color.fromRGBO(230, 231, 233, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 2.0,
      child: ListTile(
        onTap: () {
          Provider.of<ProgramacionViewModel>(context, listen: false)
              .goToProgramacionCategoria(title, context);
          /*Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => NewsPage(indicador:title)
                        )
                      );*/
        },
        leading: Icon(icon,
            size: w(40),
            color: Colors.blue[
                900]) /*Image(
                      height: 30.0,
                      image: AssetImage("assets/images/iconos/icono_control.png"),
                    )*/
        ,
        title: Text(
          title,
          style: TextStyle(
            fontSize: w(23),
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(9, 88, 145, 1),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.black54,
        ),
      ),
    );
  }
}
