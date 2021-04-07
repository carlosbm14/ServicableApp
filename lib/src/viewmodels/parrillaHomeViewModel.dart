
import 'package:appservicable/src/services/dbLocal.dart';
import 'package:appservicable/src/settings/persistence.dart';
import 'package:appservicable/src/viewmodels/estadoCuentaViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParrillaHomeViewModel extends ChangeNotifier {
  final prefs = new PersistenceLocal();
  String _nombresUser='';
  String _distritoUser='';

  int _index = 1;
  
  get distritoUser {
    return _distritoUser;
  }

  set distritoUser(String value) {
    this._distritoUser = value;
    notifyListeners();
  }

  get nombresUser {
    return _nombresUser;
  }
 
  set nombresUser(String value) {
    this._nombresUser = value;
    notifyListeners();
  }

  get index {
    return _index;
  }

  set index(int value) {
    this._index = value;
    notifyListeners();
  }

  buttonPressed(int index, context){//go estado de cuenta
     this.index= index;
    Navigator.of(context).pushNamed('dashboard');
  } 

  cerrarSesion(BuildContext context)async{
    prefs.email='';
    prefs.password='';
    prefs.isClient=false;
    prefs.numerodni='';
    prefs.tipodni='';
    Provider.of<EstadoCuentaViewModel>(context, listen: false).listProductosEstadoCuenta=null;
    await DBLocalProvider.db.deleteAllReferencia();
    Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
  }

}
