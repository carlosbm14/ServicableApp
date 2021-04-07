import 'package:appservicable/src/models/backgroundModel.dart';
import 'package:appservicable/src/models/productoSolicitud.dart';
import 'package:appservicable/src/models/servicioSolicitudServicio.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/formulariosViewModel.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/widgets/buttonSend.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioSolicitudServTecnico extends StatefulWidget {
  FormularioSolicitudServTecnico({Key key}) : super(key: key);

  @override
  _FormularioSolicitudServTecnicoState createState() => _FormularioSolicitudServTecnicoState();
}

class _FormularioSolicitudServTecnicoState extends State<FormularioSolicitudServTecnico> {
  TextEditingController especifiqueContoller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PromosViewModel>(builder: (context, model, _) {
      var promos= model.imagenesBackgrounds;
         Background foto;
         if(promos.length>0){
            foto =  promos.where((i) => i.nombre=='formulario_solicitud_servicio_tecnico').first;
         }
         else{
           Provider.of<PromosViewModel>(context, listen:false).obtenerBackgrounds();
            foto=  null;
         }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: [
            Container(
            constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgrounds/login.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: 
          (foto==null)?Offstage():
          CachedNetworkImage(
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
            
          );
        }
     ),

          ),
            Column(
              children: [
                SizedBox(
                  height: w(50),
                ),
                Container(
                  width: w(600),
                  height: w(100),
                  /*decoration: BoxDecoration(
                    //  color: Colors.red,
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/imagenes/conoceMasProductosLogo.png"),
                        fit: BoxFit.contain),
                  ),*/
                ),
                Center(
                    child: Container(
                        width: w(400),
                        child: Text(
                          'Formulario Solicitud de Servicio Técnico',
                          style: TextStyle(
                            fontSize: f(30),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: w(30)),
                _inputsFormulario(),
              ],
            ),
            Positioned(
                bottom: w(50),
                left: w(43),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¡Nos vemos pronto!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: f(30),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: w(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        sendButton(() {
                           final vm= Provider.of<PromosViewModel>(context, listen: false);
          ///producto selected
          List<ProductoSolicitud> lista = vm.productosSolicitud;
          final selected = lista.where((i) => i.id.toString()== vm.productoSolicitudSelected).first;
          var productoText = selected.nombre;

          ///servicio selected
          List<ServicioSolicitud> lista2 = vm.serviciosSolicitud;
          final selected2 = lista2.where((i) => i.key.toString()== vm.servicioSolicitudSelected).first;
          var servicioText = selected2.nombre;
                           Provider.of<FormularioViewModel>(context,
                                  listen: false).enviarSolicitudServicioTecnico(
                                 context,
                                 productoText.toUpperCase(),
                                 servicioText.toUpperCase(),
                                  especifiqueContoller.text.toUpperCase());
                        }),
                        SizedBox(width: w(10)),
                        Center(
                            child: Icon(
                          Icons.help,
                          color: Colors.white,
                          size: w(30),
                        ))
                      ],
                    ),
                    SizedBox(height: w(30)),
                    Container(color: Colors.white, width: w(400), height: w(3))
                  ],
                ))
          ],
        ));
    });
  }
  
  

  Widget _inputsFormulario() {
    return Consumer<PromosViewModel>(builder: (context, model, _) {
    
   return (model.productosSolicitud.length>0)?
   Column(
      children: [
        _dropProductos(model),
        SizedBox(height: h(10)),
        _dropServicios(model),
        SizedBox(height: h(10)),
        _createInputs(especifiqueContoller, 'Especifique (*)', TextInputType.text),
      ],
    ):
    Center(child: CircularProgressIndicator());
    });
  }
   
  
  /////////////////////////////////////////////// DEPARTAMENTOS TEST /////////////////////////////
  List<DropdownMenuItem<String>> itemsProductos(List<ProductoSolicitud> item ) {
    List<DropdownMenuItem<String>> lista = new List();
    List<ProductoSolicitud> dptos= [];
    dptos= item;
    (dptos.length>0)?
    dptos.forEach((opcion) {
      lista.add(DropdownMenuItem(
        child: Text(opcion.nombre),
        value: opcion.id.toString(),
      ));
    }):
    lista.add(DropdownMenuItem(
        child: Text('Cargando data'),
        value: '0',
      ));

    return lista;
  }

  Widget _dropProductos(PromosViewModel vm) {
    String _opcionSeleccionado = vm.productoSolicitudSelected;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(60), vertical: w(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Producto',
              style: TextStyle(fontSize: f(16), fontWeight: FontWeight.bold)),
          DropdownButton(
              isExpanded: true,
              value: _opcionSeleccionado,
              items: itemsProductos(vm.productosSolicitud),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              onChanged: (value) {
               vm.changeProductoSolicitud(value);
              }),
        ],
      ),
    );
  }
  /////////////////////////////////// FIN DEPARTAMENTOS TEST ///////////////////////////
  
  /////////////////////////////////////////////// DISTRITOS TEST /////////////////////////////
  List<DropdownMenuItem<String>> itemsServicios(List<ServicioSolicitud> item) {
    List<DropdownMenuItem<String>> lista = new List();
    (item.length>0)?
    item.forEach((opcion) {
      lista.add(DropdownMenuItem(
        child: Text(opcion.nombre),
        value: opcion.key.toString(),
      ));
    }):
     lista.add(DropdownMenuItem(
        child: Text('No posee Servicios asociados'),
        value: '-1',
      ));

    return lista;
  }

  Widget _dropServicios(PromosViewModel vm) {
    String _opcionSeleccionado = vm.servicioSolicitudSelected;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(60), vertical: w(0)),
      child: (vm.serviciosSolicitud.length>0)?
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Servicio',
              style: TextStyle(fontSize: f(16), fontWeight: FontWeight.bold)),
          DropdownButton(
              isExpanded: true,
              value: _opcionSeleccionado,
              items: itemsServicios(vm.serviciosSolicitudFiltrados),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              onChanged: (value) {
               vm.servicioSolicitudSelected= value;
              }),
        ],
      ):
      Center(child: CircularProgressIndicator(),),
    );
  }
  /////////////////////////////////// FIN DEPARTAMENTOS TEST ///////////////////////////

}

  Widget _createInputs(TextEditingController controller, String titulo,
      TextInputType tipoTeclado) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(60), vertical: w(5)),
      child: Column(
        children: [
          Align(
              alignment: Alignment.bottomLeft,
              child:
                  Text(titulo, style: TextStyle(fontWeight: FontWeight.bold))),
          TextField(
            maxLength: 500,
            maxLines: 7,
            controller: controller,
            keyboardType: tipoTeclado,
            style: TextStyle(
              height: 1,
            ),
            cursorColor: Colors.blue,
          ),
        ],
      ),
    );
  }
