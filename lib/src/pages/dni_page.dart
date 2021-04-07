import 'package:appservicable/src/settings/responsiveSize.dart';
import 'package:appservicable/src/viewmodels/dniViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DniPage extends StatefulWidget {
  @override
  _DniPageState createState() => _DniPageState();
}

class _DniPageState extends State<DniPage> {
  int _tipodni = 1;
  TextEditingController _inputDniContoller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: SizesCustom.width,
        height: SizesCustom.height,
        allowFontScaling: true);
    final _screenLocal = MediaQuery.of(context).size;
    final _screenLocalH = _screenLocal.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage("assets/images/backgrounds/login.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: w(20),
              ),
              _logoServicable(),
              SizedBox(
                height: w(40),
              ),
              Center(
                child: Card(
                  elevation: 10,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        top: w(20), left: w(20), right: w(20), bottom: w(20)),
                    width: w(400),
                    height: w(415),
                    child: ListView(
                      children: <Widget>[
                        Text(
                            'Accede a Servicable ingresando tu Número de Documento',
                            style: TextStyle(
                              fontSize: f(20),
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: w(30)),
                        _crearDropDownTipoDni(_screenLocalH),
                        SizedBox(
                          height: _screenLocalH * 0.04,
                        ),
                        _createInputDni(_screenLocalH),
                        SizedBox(
                          height: _screenLocalH * 0.05,
                        ),
                        _createSendButton(_screenLocalH),
                        SizedBox(
                          height: _screenLocalH * 0.05,
                        ),
                        SizedBox(height: w(50)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _screenLocalH * 0.05,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _logoServicable() {
    return Padding(
      padding: EdgeInsets.all(w(50)),
      child: Image(
        image: AssetImage("assets/images/logos/color_logo.png"),
      ),
    );
  }

  Widget _crearDropDownTipoDni(_screenLocalH) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
              top: w(5), bottom: w(5), left: w(15), right: w(6)),
          //height: _screenLocalH * 0.0015,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color.fromRGBO(216, 217, 217, 1),
          ),
          child: DropdownButton(
              isExpanded: true,
              value: _tipodni,
              items: [

                /*this.tipodni=(tipoDni=='1')?'DNI':
       (tipoDni=='2')?'CEDULA':
       (tipoDni=='3')?'CARNET DE EXTRANJERIA':
       (tipoDni=='4')?'RUC':
        (tipoDni=='5')?'PASAPORTE':
       (tipoDni=='6')?'PTP':
       'DNI';*/


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
              onChanged: (value) {
                setState(() {
                  _tipodni = value;
                });
              }),
        ),
       /* Positioned(
            top: w(-3),
            left: w(15),
            child: Text('Tipo DNI', style: TextStyle(fontSize: f(16))))*/
      ],
    );
  }

  Widget _createInputDni(_screenLocalH) {
    return TextField(
      controller: _inputDniContoller,
      style: TextStyle(
        height: _screenLocalH * 0.0015,
      ),
      cursorColor: Colors.blueGrey,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.transparent)),
        fillColor: Color.fromRGBO(216, 217, 217, 1),
        filled: true,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        labelText: 'Número Documento',
      ),
    );
  }

  Widget _createSendButton(_screenLocalH) {
    return Container(
      height: _screenLocalH * 0.06,
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white)),
        shadowColor: Color.fromRGBO(206, 207, 207, 1),
        color: Colors.blue[900],
        elevation: 7.0,
        child: InkWell(
          onTap: () async {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
            Provider.of<DniViewModel>(context, listen: false).continuarPressed(
                context, _inputDniContoller.text, _tipodni.toString());
          },
          child: Center(
            child: Text(
              'CONTINUAR',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: _screenLocalH * 0.03,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
