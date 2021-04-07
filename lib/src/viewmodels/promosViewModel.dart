import 'package:appservicable/src/models/backgroundModel.dart';
import 'package:appservicable/src/models/carruselModel.dart';
import 'package:appservicable/src/models/planesAumentoMegasModel.dart';
import 'package:appservicable/src/models/planesProductoModel.dart';
import 'package:appservicable/src/models/productCategoryModel.dart';
import 'package:appservicable/src/models/productoAumentodeMegas.dart';
import 'package:appservicable/src/models/productoSolicitud.dart';
import 'package:appservicable/src/models/promoModel.dart';
import 'package:appservicable/src/models/servicioSolicitudServicio.dart';
import 'package:appservicable/src/models/tipoProductoModel.dart';
import 'package:appservicable/src/services/apiServices.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:appservicable/src/models/departamentoModel.dart';
import 'package:appservicable/src/models/distritoModel.dart';


class PromosViewModel extends ChangeNotifier {
  List<Departamento> _departamentos = [];
  String _departamentoSelected = '0';
  String _distritoSelected = '0';
  List<Distrito> _distritos = [];
  List<Distrito> _distritosFiltrados = [];

  List<ProductoSolicitud> _productosSolicitud = [];
  String _productoSolicitudSelected = '0';
  String _servicioSolicitudSelected = '0';
  List<ServicioSolicitud> _serviciosSolicitud = [];
  List<ServicioSolicitud> _serviciosSolicitudFiltrados = [];
  List<PlanesAumentoMegas> _planesAumentoMegas = [];

  List<Promo> _imagenesPromo = [];
  List<Carrusel> _imagenesCarrusel = [];
  List<ProductCategory> _imagenesProductosCategory = [];
  List<TipoProducto> _imagenesTipoProductos = [];
  List<PlanesProducto> _imagenesPlanesProductos = [];
  List<Background> _imagenesBackgrounds = [];
  ProductCategory _productSelected;
  TipoProducto _tipoProductSelected;
  List<TipoProducto> _tiposProductosSelected=[];
  List<PlanesProducto> _planesProductosSelected=[];
  List<ProductoAumentodeMegas> _productosAumentoMegas=[];
  List<PlanesAumentoMegas> _planesAumentodeMegasFiltrados=[];
  String _productoAumentodeMegasSeleccionados= "0";
  String _planAumentodeMegasSeleccionados = "0";

get planAumentodeMegasSeleccionados {
    return _planAumentodeMegasSeleccionados;
  }

  set planAumentodeMegasSeleccionados(String value) {
    this._planAumentodeMegasSeleccionados = value;
    notifyListeners();
  }



get productoAumentodeMegasSeleccionados {
    return _productoAumentodeMegasSeleccionados;
  }

  set productoAumentodeMegasSeleccionados(String value) {
    this._productoAumentodeMegasSeleccionados = value;
    notifyListeners();
  }


get planesAumentodeMegasFiltrados {
    return _planesAumentodeMegasFiltrados;
  }

  set planesaumentodemegasFiltrados(List<PlanesAumentoMegas> value) {
    this._planesAumentodeMegasFiltrados = value;
    notifyListeners();
  }


  get productosAumentoMegas {
    return _productosAumentoMegas;
  }

  set productosAumentoMegas(List<ProductoAumentodeMegas> value) {
    this._productosAumentoMegas = value;
    notifyListeners();
  }
  
  get planesAumentoMegas {
    return _planesAumentoMegas;
  }

  set planesAumentoMegas(List<PlanesAumentoMegas> value) {
    this._planesAumentoMegas = value;
    notifyListeners();
  }

  get servicioSolicitudSelected {
    return _servicioSolicitudSelected;
  }

  set servicioSolicitudSelected(String value) {
    this._servicioSolicitudSelected = value;
    notifyListeners();
  }

  get productoSolicitudSelected {
    return _productoSolicitudSelected;
  }

  set productoSolicitudSelected(String value) {
    this._productoSolicitudSelected = value;
    notifyListeners();
  }

  get productosSolicitud {
    return _productosSolicitud;
  }

  set productosSolicitud(List<ProductoSolicitud> value) {
    this._productosSolicitud = value;
    notifyListeners();
  }
  
  get serviciosSolicitudFiltrados {
    return _serviciosSolicitudFiltrados;
  }

  set serviciosSolicitudFiltrados(List<ServicioSolicitud> value) {
    this._serviciosSolicitudFiltrados = value;
    notifyListeners();
  }

  get serviciosSolicitud {
    return _serviciosSolicitud;
  }

  set serviciosSolicitud(List<ServicioSolicitud> value) {
    this._serviciosSolicitud = value;
    notifyListeners();
  }
  ////////////////////
  get distritoSelected {
    return _distritoSelected;
  }

  set distritoSelected(String value) {
    this._distritoSelected = value;
    notifyListeners();
  }

  get departamentoSelected {
    return _departamentoSelected;
  }

  set departamentoSelected(String value) {
    this._departamentoSelected = value;
    notifyListeners();
  }

  get departamentos {
    return _departamentos;
  }

  set departamentos(List<Departamento> value) {
    this._departamentos = value;
    notifyListeners();
  }
  
  get distritosFiltrados {
    return _distritosFiltrados;
  }

  set distritosFiltrados(List<Distrito> value) {
    this._distritosFiltrados = value;
    notifyListeners();
  }

  get distritos {
    return _distritos;
  }

  set distritos(List<Distrito> value) {
    this._distritos = value;
    notifyListeners();
  }

  get planesProductosSelected {
    return _planesProductosSelected;
  }

  set planesProductosSelected(List<PlanesProducto> value) {
    this._planesProductosSelected = value;
    notifyListeners();
  }

  get tipoProductSelected {
    return _tipoProductSelected;
  }

  set tipoProductSelected(TipoProducto value) {
    this._tipoProductSelected = value;
    notifyListeners();
  }

   get tiposProductosSelected {
    return _tiposProductosSelected;
  }

  set tiposProductosSelected(List<TipoProducto> value) {
    this._tiposProductosSelected = value;
    notifyListeners();
  }

  get productSelected {
    return _productSelected;
  }

  set productSelected(ProductCategory value) {
    this._productSelected = value;
    notifyListeners();
  }

   get imagenesBackgrounds {
    return _imagenesBackgrounds;
  }

  set imagenesBackgrounds(List<Background> value) {
    this._imagenesBackgrounds = value;
    notifyListeners();
  }

   get imagenesPlanesProductos {
    return _imagenesPlanesProductos;
  }

  set imagenesPlanesProductos(List<PlanesProducto> value) {
    this._imagenesPlanesProductos = value;
    notifyListeners();
  }

   get imagenesTipoProductos {
    return _imagenesTipoProductos;
  }

  set imagenesTipoProductos(List<TipoProducto> value) {
    this._imagenesTipoProductos = value;
    notifyListeners();
  }

   get imagenesProductosCategory {
    return _imagenesProductosCategory;
  }

  set imagenesProductosCategory(List<ProductCategory> value) {
    this._imagenesProductosCategory = value;
    notifyListeners();
  }

   get imagenesCarrusel {
    return _imagenesCarrusel;
  }

  set imagenesCarrusel(List<Carrusel> value) {
    this._imagenesCarrusel = value;
    notifyListeners();
  }

  get imagenesPromo {
    return _imagenesPromo;
  }

  set imagenesPromo(List<Promo> value) {
    this._imagenesPromo = value;
    notifyListeners();
  }

   obtenerpromos()async{
      final promos= await obtenerListaPromos();
      this.imagenesPromo=promos;
   }

   obtenerCarruselImages() async{
     final carrusel= await obtenerListaCarrusel();
     this.imagenesCarrusel = carrusel;
   }

   obtenerCategoriaProductos() async{
     final productosCategory = await obtenerListaProductosPrincipal();
     this.imagenesProductosCategory = productosCategory;
   }

   obtenerTiposProductos() async{
     final tipoProductos = await obtenerListaTipoProductos();
     this.imagenesTipoProductos = tipoProductos;

   }

   planesProductos() async{
     final planesProductos = await obtenerListaPlanesProductos();
     print(planesProductos.length);
     this.imagenesPlanesProductos = planesProductos;
   }

   Future<void> obtenerDepartamentos() async{
    final dpto = await obtenerListaDepartamentos();
    this.departamentos = dpto;
    changeDepartamento(dpto.first.id.toString());
  }

  Future<void> obtenerDistritos() async{
    final dtto = await obtenerListaDistritos();
    this.distritos = dtto;
    obtenerDepartamentos();
  }

  Future<void> obtenerBackgrounds() async{
    final backgrounds = await obtenerListaBackgrounds();
    this.imagenesBackgrounds = backgrounds;
  }

  Future<void> obtenerProductosSolicitudServicios() async{
    final productos = await getProductosSolicitudServicios();
    this.productosSolicitud= productos;
    changeProductoSolicitud(productos.first.id.toString());
  }

  Future<void> obtenerServiciosSolicitudServicios() async{
    final servicios = await getServiciosSolicitudServicios();
    this.serviciosSolicitud = servicios;
    obtenerProductosSolicitudServicios();
  }

  Future<void> obtenerPlanesAumentodemegas() async{
    final planes = await getPlanesAumentodeMegas();
    this.planesAumentoMegas = planes;
    obtenerProductosAumentodeMegas();
  }

  Future<void> obtenerProductosAumentodeMegas() async{
    final planes = await getProductosAumentodeMegas();
    this.productosAumentoMegas = planes;
    changeProductoAumentodemegas(planes.first.id.toString());
      }
    
      goProductosTipos(ProductCategory productoSelected, context){
        this.productSelected= productoSelected;
         List<TipoProducto> tiposproducto= this.imagenesTipoProductos.where((i) => i.idCategoria==productoSelected.id).toList();
         this.tiposProductosSelected=tiposproducto;
         if(tiposproducto.length>0){
              Navigator.pushNamed(context, 'productosTipos');
         }
         else{
           Toast.show(
                    "En Construcción...",
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    textColor: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.85),
                  );
         }
         
      }
    
       goPlanesProductos(TipoProducto tipo, context) {
    
         this.tipoProductSelected= tipo;
         List<PlanesProducto> planesSelected= this.imagenesPlanesProductos.where((i) => i.idTipo ==tipo.id).toList();
         this.planesProductosSelected = planesSelected;
         if(planesSelected.length>0){
              Navigator.pushNamed(context, 'productosPlanes');
         }
         else{
           Toast.show(
                    "No existen Planes para éste Producto...",
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    textColor: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.85),
                  );
         }
      }
    
      void changeDepartamento(String idDepartamento) {
        List<Distrito> dttos= this.distritos;
        final distritosFiltrados = dttos.where((i) => i.departamentoId.toString() == idDepartamento).toList();
        this.distritosFiltrados= distritosFiltrados;
        this.distritoSelected= (distritosFiltrados.length==0)?'-1':distritosFiltrados.first.key;
        this.departamentoSelected = idDepartamento;
      }
    
      void changeProductoSolicitud(String idProducto) {
        List<ServicioSolicitud> servcios= this.serviciosSolicitud;
        final servFiltrados = servcios.where((i) => i.productoId.toString() == idProducto).toList();
        this.serviciosSolicitudFiltrados= servFiltrados;
        this.servicioSolicitudSelected= (servFiltrados.length==0)?'-1':servFiltrados.first.key;
        this.productoSolicitudSelected = idProducto;
      }
    
    
    void changeProductoAumentodemegas(String idProducto) {
  List<PlanesAumentoMegas> planes= this.planesAumentoMegas;
        final servFiltrados = planes.where((i) => i.productoId.toString() == idProducto).toList();
        this._planesAumentodeMegasFiltrados= servFiltrados;
        this.planAumentodeMegasSeleccionados= (servFiltrados.length==0)?'-1':servFiltrados.first.key;
        this.productoAumentodeMegasSeleccionados = idProducto;

}

}