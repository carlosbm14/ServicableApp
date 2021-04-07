import 'package:appservicable/src/models/backgroundModel.dart';
import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/promosViewModel.dart';
import 'package:appservicable/src/viewmodels/registroViewModel.dart';
import 'package:appservicable/src/widgets/buttonSend.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:appservicable/src/settings/persistence.dart';
import 'package:appservicable/src/models/departamentoModel.dart';
import 'package:appservicable/src/models/distritoModel.dart';



class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  int dropdownTipoDni = 1;

  final prefs = new PersistenceLocal();
  final FocusNode myFocusNode = FocusNode();
  TextEditingController _inputPassContoller = new TextEditingController();
  TextEditingController _inputNombreContoller = new TextEditingController();
  TextEditingController _inputTelefonoContoller = new TextEditingController();
  TextEditingController _inputEmailContoller = new TextEditingController();
  TextEditingController _inputDniContoller = new TextEditingController();
  String distritoSelected = 'Cercado de Lima';
  String departamentoSelected = 'Lima';
  String tipoDNI = 'DNI';

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     final List<Background> promos =
        Provider.of<PromosViewModel>(context, listen: false)
            .imagenesBackgrounds;
    var foto;
    if (promos.length > 0) {
      foto = promos.where((i) => i.nombre == 'login').first;
    }
    ScreenUtil.init(context,
        width: SizesCustom.width,
        height: SizesCustom.height,
        allowFontScaling: true);
    final _screenLocal = MediaQuery.of(context).size;
    final _screenLocalH = _screenLocal.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Registro de Usuario',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(children: <Widget>[
        Consumer<PromosViewModel>(builder: (context, model, _) {
          return Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: CachedNetworkImageProvider(foto.urlImage)),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: w(60), vertical: w(20)),
                child: _logoServicable(),
              ),
              SizedBox(
                height: _screenLocalH * 0.000,
              ),
              Center(
                child: Container(
                  height: w(520),
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: w(0), vertical: w(10)),
                    children: <Widget>[
                      _createInputs(_inputNombreContoller, 'Nombres y Apellidos',
                          TextInputType.text),
                      
                      SizedBox(
                        height: _screenLocalH * 0.02,
                      ),
                      _dropdownTipoDni(context),
                      
                      SizedBox(
                        height: _screenLocalH * 0.02,
                      ),
                      _createInputs(_inputDniContoller, 'Número de Documento',
                          TextInputType.text),



                      SizedBox(
                        height: _screenLocalH * 0.02,
                      ),
                      _createInputs(_inputEmailContoller, 'Email',
                          TextInputType.emailAddress),
                      
                      SizedBox(
                        height: _screenLocalH * 0.02,
                      ),
                      _createInputs(
                          _inputPassContoller, 'Contraseña', TextInputType.text,
                          pass: 'password'),

                      SizedBox(
                        height: _screenLocalH * 0.02,
                      ),
                      _createInputs(_inputTelefonoContoller, 'Teléfono',
                          TextInputType.phone),
                      SizedBox(
                        height: _screenLocalH * 0.02,
                      ),
                      _dropDepartamentos(model),
                      SizedBox(
                        height: _screenLocalH * 0.02,
                      ),
                      
                      _dropDistritos(model),
                      SizedBox(
                        height: _screenLocalH * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: h(100),
              ),
              _createSendButton(_screenLocalH),
              SizedBox(height: w(30)),
              Container(color: Colors.white, width: w(400), height: w(3))
            ],
          ),
        );
        })
      ]),
    );
  }

  Widget _logoServicable() {
    return Image(
      image: AssetImage("assets/images/logos/newLogoServi.png"),
    );
  }

  Widget _createInputs(TextEditingController controller, String titulo,
      TextInputType tipoTeclado,
      {String pass}) {
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
            obscureText: (pass == null) ? false : true,
            style: TextStyle(
              height: 1,
            ),
            cursorColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _dropdownTipoDni(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w(60), vertical: w(0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tipo de Documento',
              style: TextStyle(fontSize: f(16), fontWeight: FontWeight.bold)),
          DropdownButton(
              isExpanded: true,
              value: dropdownTipoDni,
              items: [
                DropdownMenuItem(
                  child: Text("DNI", style: TextStyle(fontSize: f(20))),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("CÉDULA", style: TextStyle(fontSize: f(20))),
                  value: 2,
                ),
                DropdownMenuItem(
                    child: Text("CARNET DE EXTRANJERÍA",
                        style: TextStyle(fontSize: f(20))),
                    value: 3),
                DropdownMenuItem(
                  child: Text("RUC", style: TextStyle(fontSize: f(20))),
                  value: 4,
                ),
                DropdownMenuItem(
                    child: Text("PASAPORTE", style: TextStyle(fontSize: f(20))),
                    value: 5),
                DropdownMenuItem(
                    child: Text("PTP", style: TextStyle(fontSize: f(20))),
                    value: 6),
              ],
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              onChanged: (value) {
                setState(() {
                  dropdownTipoDni = value;
                  tipoDNI = (value == 1)
                      ? 'DNI'
                      : (value == 2)
                          ? 'CEDULA'
                          : (value == 3)
                              ? 'CARNET DE EXTRANJERIA'
                              : (value == 4)
                                  ? 'RUC'
                                  : (value == 5)
                                      ? 'PASAPORTE'
                                      : (value == 6)
                                          ? 'PTP'
                                          : 'DNI';
                });
              }),
        ],
      ),
    );
  }

  Widget _createSendButton(_screenLocalH) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w(10)),
      height: _screenLocalH * 0.06,
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white)),
        shadowColor: Color.fromRGBO(206, 207, 207, 1),
        color: Colors.blue[900],
        elevation: 7.0,
        child: sendButton(() {
          final vm= Provider.of<PromosViewModel>(context, listen: false);
          ///departamento selected
          List<Departamento> lista = vm.departamentos;
          final selected = lista.where((i) => i.id.toString()== vm.departamentoSelected).first;
          var departamentoText = selected.nombre;

          ///distrito selected
          List<Distrito> lista2 = vm.distritos;
          final selected2 = lista2.where((i) => i.key.toString()== vm.distritoSelected).first;
          var distritoText = selected2.nombre;

          Provider.of<RegistroViewModel>(context, listen: false)
              .registrarButtonPressed(context,
                  pass: _inputPassContoller.text,
                  telefono: _inputTelefonoContoller.text,
                  nombres: _inputNombreContoller.text,
                  email: _inputEmailContoller.text,
                  dpto: departamentoText,
                  dtrto: distritoText,
                  dni: _inputDniContoller.text,
                  tipoDni: tipoDNI);
        },
            titleText:
                'Registrarme')
        ,
      ),
    );
  }


  /////////////////////////////////////////////// DEPARTAMENTOS TEST /////////////////////////////
  List<DropdownMenuItem<String>> itemsDepartamentos(PromosViewModel vm) {
    List<DropdownMenuItem<String>> lista = new List();
    List<Departamento> dptos= vm.departamentos;
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
    List<Distrito> dptos= vm.distritosFiltrados;
    (dptos.length>0)?
    dptos.forEach((opcion) {
      lista.add(DropdownMenuItem(
        child: Text(opcion.nombre),
        value: opcion.key.toString(),
      ));
    }):
     lista.add(DropdownMenuItem(
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
               vm.distritoSelected= value;
              }),
        ],
      ):
      Center(child: CircularProgressIndicator(),),
    );
  }
  /////////////////////////////////// FIN DEPARTAMENTOS TEST ///////////////////////////

}
