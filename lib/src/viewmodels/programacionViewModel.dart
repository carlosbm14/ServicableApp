import 'package:appservicable/src/models/programacionModel.dart';
import 'package:appservicable/src/services/apiServices.dart';
import 'package:flutter/material.dart';

class ProgramacionViewModel extends ChangeNotifier {
  List<Programacion> _imagenesCanales = [];
  List<Programacion> _categoriaProgramacionSelected=[];
  
  get categoriaProgramacionSelected {
    return _categoriaProgramacionSelected;
  }

  set categoriaProgramacionSelected(List<Programacion> value) {
    this._categoriaProgramacionSelected = value;
    notifyListeners();
  }

  get imagenesCanales {
    return _imagenesCanales;
  }

  set imagenesCanales(List<Programacion> value) {
    this._imagenesCanales = value;
    notifyListeners();
  }
   
   goToProgramacionCategoria(String categoria, BuildContext context){

     String categ=(categoria=='DEPORTES')?'deportes':
     (categoria=='SERIES Y PELICULAS')?'series_peliculas':
     (categoria=='DOCUMENTALES')?'documentales':
     (categoria=='INFANTIL')?'infantil':
     (categoria=='NOTICIAS Y RELIGIOSO')?'noticias_religioso':
     (categoria=='VARIADOS')?'variados':
     (categoria=='NACIONAL')?'nacionales':
     (categoria=='DEPORTES')?'deportes':
     (categoria=='TELENOVELAS Y MUSICALES')?'telenovelas_musicales':
     'variados';
     final List<Programacion> canales= this.imagenesCanales;
     this.categoriaProgramacionSelected= canales.where((i) => i.categoria==categ).toList();
     Navigator.pushNamed(context, 'PageViewCanales');
   }

   obtenerprogramacion()async{
      final programas= await obtenerListaProgramacion();
      this.imagenesCanales= programas;
   }
}