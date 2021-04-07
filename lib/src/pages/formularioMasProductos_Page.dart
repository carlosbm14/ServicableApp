import 'package:appservicable/src/models/backgroundModel.dart';
import 'package:appservicable/src/models/departamentoModel.dart';
import 'package:appservicable/src/models/distritoModel.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/formulariosViewModel.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/widgets/buttonSend.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioMasProductos extends StatefulWidget {
  FormularioMasProductos({Key key}) : super(key: key);

  @override
  _FormularioMasProductosState createState() => _FormularioMasProductosState();
}

class _FormularioMasProductosState extends State<FormularioMasProductos> {
  TextEditingController nombreContoller = new TextEditingController();
  TextEditingController telefonoContoller = new TextEditingController();
  TextEditingController correoContoller = new TextEditingController();
  TextEditingController distritoContoller = new TextEditingController();
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {

     return Consumer<PromosViewModel>(builder: (context, model, _) {
      var promos= model.imagenesBackgrounds;
         Background foto;
         if(promos.length>0){
            foto =  promos.where((i) => i.nombre=='conoce_masproductos').first;
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
                  decoration: BoxDecoration(
                    //  color: Colors.red,
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/imagenes/conoceMasProductosLogo.png"),
                        fit: BoxFit.contain),
                  ),
                ),
                Center(
                    child: Container(
                        width: w(400),
                        child: Text(
                          'Regístrate y nos pondremos en contacto.',
                          style: TextStyle(
                            fontSize: f(30),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: w(30)),
                _inputsFormulario(),
                _checkbox(),
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
                          final vm = Provider.of<PromosViewModel>(context,
                              listen: false);

                          ///departamento selected
                          List<Departamento> lista = vm.departamentos;
                          final selected = lista
                              .where((i) =>
                                  i.id.toString() == vm.departamentoSelected)
                              .first;
                          var departamentoText = selected.nombre;

                          ///distrito selected
                          List<Distrito> lista2 = vm.distritos;
                          final selected2 = lista2
                              .where((i) =>
                                  i.key.toString() == vm.distritoSelected)
                              .first;
                          var distritoText = selected2.nombre;
                          String recibirPublicidad =
                              (checkedValue.toString() == 'false')
                                  ? "No"
                                  : "Si";

                          Provider.of<FormularioViewModel>(context,
                                  listen: false)
                              .enviarEstadistica(
                                  context,
                                  nombreContoller.text.toUpperCase(),
                                  telefonoContoller.text.toUpperCase(),
                                  correoContoller.text.toUpperCase(),
                                  departamentoText.toUpperCase(),
                                  distritoText.toUpperCase(),
                                  recibirPublicidad.toUpperCase());
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
      return Container(
        height: h(350),
        child: ListView(
          shrinkWrap: true,
          children: [
            _createInputs(
                nombreContoller, 'Nombres y Apellidos', TextInputType.text),
            _createInputs(telefonoContoller, 'Teléfono', TextInputType.phone),
            _createInputs(
                correoContoller, 'Correo', TextInputType.emailAddress),
            SizedBox(height: w(10)),
            _dropDepartamentos(model),
            SizedBox(height: w(10)),
            _dropDistritos(model),
          ],
        ),
      );
    });
  }

  /////////////////////////////////////////////// DEPARTAMENTOS TEST /////////////////////////////
  List<DropdownMenuItem<String>> itemsDepartamentos(PromosViewModel vm) {
    List<DropdownMenuItem<String>> lista = new List();
    List<Departamento> dptos = vm.departamentos;
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

  Widget _dropDepartamentos(PromosViewModel vm) {
    String _opcionSeleccionado = vm.departamentoSelected;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(60), vertical: w(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Departamento',
              style: TextStyle(fontSize: f(16), fontWeight: FontWeight.bold)),
          DropdownButton(
              isExpanded: true,
              value: _opcionSeleccionado,
              items: itemsDepartamentos(vm),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              onChanged: (value) {
                vm.changeDepartamento(value);
              }),
        ],
      ),
    );
  }
  /////////////////////////////////// FIN DEPARTAMENTOS TEST ///////////////////////////

  /////////////////////////////////////////////// DISTRITOS TEST /////////////////////////////
  List<DropdownMenuItem<String>> itemsDistritos(PromosViewModel vm) {
    List<DropdownMenuItem<String>> lista = new List();
    List<Distrito> dptos = vm.distritosFiltrados;
    (dptos.length > 0)
        ? dptos.forEach((opcion) {
            lista.add(DropdownMenuItem(
              child: Text(opcion.nombre),
              value: opcion.key.toString(),
            ));
          })
        : lista.add(DropdownMenuItem(
            child: Text('No posee distrito asociado'),
            value: '-1',
          ));

    return lista;
  }

  Widget _dropDistritos(PromosViewModel vm) {
    String _opcionSeleccionado = vm.distritoSelected;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(60), vertical: w(0)),
      child: 
      (vm.distritos.length>0)?
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Distrito',
              style: TextStyle(fontSize: f(16), fontWeight: FontWeight.bold)),
          DropdownButton(
              isExpanded: true,
              value: _opcionSeleccionado,
              items: itemsDistritos(vm),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              onChanged: (value) {
                vm.distritoSelected = value;
              }),
        ],
      ): Center(child: CircularProgressIndicator(),),

    );
  }

  /////////////////////////////////// FIN DEPARTAMENTOS TEST ///////////////////////////
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

  Widget _checkbox() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(55)),
      child: CheckboxListTile(
        title: Text(
          "Acepto recibir publicidad o información promocional de SERVI CABLE SAC",
          style: TextStyle(fontSize: w(17)),
        ),
        value: checkedValue,
        onChanged: (newValue) {
          checkedValue = newValue;
          setState(() {});
        },
        contentPadding: EdgeInsets.symmetric(horizontal: w(0)),
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }
}
