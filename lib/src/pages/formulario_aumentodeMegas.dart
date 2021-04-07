import 'package:appservicable/src/models/backgroundModel.dart';
import 'package:appservicable/src/models/planesAumentoMegasModel.dart';
import 'package:appservicable/src/models/productoAumentodeMegas.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/widgets/buttonSend.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appservicable/src/viewmodels/formulariosViewModel.dart';


class FormularioAumentoMegas extends StatefulWidget {
  FormularioAumentoMegas({Key key}) : super(key: key);

  @override
  _FormularioAumentoMegasState createState() => _FormularioAumentoMegasState();
}

class _FormularioAumentoMegasState extends State<FormularioAumentoMegas> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<PromosViewModel>(builder: (context, model, _) {
      var promos= model.imagenesBackgrounds;
         Background foto;
         if(promos.length>0){
            foto =  promos.where((i) => i.nombre=='formulario_aumento_de_megas').first;
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
                ),
                Center(
                    child: Container(
                        width: w(400),
                        child: Text(
                          'Formulario de Aumento de Megas',
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
          List<ProductoAumentodeMegas> lista = vm.productosAumentoMegas;
          final selected = lista.where((i) => i.id.toString()== vm.productoAumentodeMegasSeleccionados).first;
          var productoText = selected.nombre;

          ///servicio selected
          List<PlanesAumentoMegas> lista2 = vm.planesAumentoMegas;
          final selected2 = lista2.where((i) => i.key.toString()== vm.planAumentodeMegasSeleccionados).first;
          var servicioText = selected2.nombre;
                           Provider.of<FormularioViewModel>(context,
                                  listen: false).enviarAumentodeMegas(
                                 context,
                                 productoText.toUpperCase(),
                                 servicioText.toUpperCase(),);
                                 
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
    return 
    (model.productosAumentoMegas.length>0)?
    Column(
      children: [
        _dropProductos(model),
        SizedBox(height: h(10)),
        _dropPlanes(model),
        SizedBox(height: h(10)),
       // _createInputs(especifiqueContoller, 'Especifique (*)', TextInputType.text),
      ],
    ):    Center(child: CircularProgressIndicator());
    });
  }
   
  //   List<ProductoAumentodeMegas> _productosAumentoMegas=[];
  // List<PlanesAumentoMegas> _planesAumentodeMegasFiltrados=[];
  
  /////////////////////////////////////////////// DEPARTAMENTOS TEST /////////////////////////////
  List<DropdownMenuItem<String>> itemsProductos(List<ProductoAumentodeMegas> listas) {
    List<DropdownMenuItem<String>> lista = new List();
    (listas.length>0)?
    listas.forEach((opcion) {
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
    String _opcionSeleccionado = vm.productoAumentodeMegasSeleccionados;
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
              items: itemsProductos(vm.productosAumentoMegas),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              onChanged: (value) {
               vm.changeProductoAumentodemegas(value);
              }),
        ],
      ),
    );
  }
  /////////////////////////////////// FIN DEPARTAMENTOS TEST ///////////////////////////
  
  /////////////////////////////////////////////// DISTRITOS TEST /////////////////////////////
  List<DropdownMenuItem<String>> itemsServicios(PromosViewModel vm) {
    List<DropdownMenuItem<String>> lista = new List();
    List<PlanesAumentoMegas> dptos= [];
     dptos= vm.planesAumentodeMegasFiltrados;
    (dptos.length>0)?
    dptos.forEach((opcion) {
      lista.add(DropdownMenuItem(
        child: Text(opcion.nombre),
        value: opcion.key.toString(),
      ));
    }):
     lista.add(DropdownMenuItem(
        child: Text('No posee planes asociados'),
        value: '-1',
      ));

    return lista;
  }

  Widget _dropPlanes(PromosViewModel vm) {
    String _opcionSeleccionado = vm.planAumentodeMegasSeleccionados;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(60), vertical: w(0)),
      child: (vm.planesAumentoMegas.length>0)?
      
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Servicio',
              style: TextStyle(fontSize: f(16), fontWeight: FontWeight.bold)),
          DropdownButton(
              isExpanded: true,
              value: _opcionSeleccionado,
              items: itemsServicios(vm),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              onChanged: (value) {
               vm.planAumentodeMegasSeleccionados= value;
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


