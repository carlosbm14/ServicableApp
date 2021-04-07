import 'package:shared_preferences/shared_preferences.dart';

class PersistenceLocal {
  static final PersistenceLocal _instancia =
      new PersistenceLocal._internal();

  factory PersistenceLocal() {
    return _instancia;
  }

  PersistenceLocal._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }
  
  double get widthDevice {
    return _prefs.getDouble('widthDevice') ?? 0;
  }

  set widthDevice(double value) {
    _prefs.setDouble('widthDevice', value);
  }

  double get heightDevice {
    return _prefs.getDouble('heightDevice') ?? 0;
  }

  set heightDevice(double value) {
    _prefs.setDouble('heightDevice', value);
  }

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

   get keyUserLog {
    return _prefs.getString('keyUserLog') ?? '';
  }

  set keyUserLog(String value) {
    _prefs.setString('keyUserLog', value);
  }

   get uidUser {
    return _prefs.getString('uidUser') ?? '';
  }

  set uidUser(String value) {
    _prefs.setString('uidUser', value);
  }

  get respuest {
    return _prefs.getString('respuest') ?? '';
  }

  set respuest(String value) {
    _prefs.setString('respuest', value);
  }

  get isClient {
    return _prefs.getBool('isClient') ?? false;
  }

  set isClient(bool value) {
    _prefs.setBool('isClient', value);
  }
 
 get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }
  
  get password {
    return _prefs.getString('password') ?? '';
  }

  set password(String value) {
    _prefs.setString('password', value);
  }
  
  get tipodni {
    return _prefs.getString('tipodni') ?? '';
  }

  set tipodni(String value) {
    _prefs.setString('tipodni', value);
  }
  
  get numerodni {
    return _prefs.getString('numerodni') ?? '';
  }

  set numerodni(String value) {
    _prefs.setString('numerodni', value);
  }

  get nombres {
    return _prefs.getString('nombres') ?? 'App Servicable';
  }

  set nombres(String value) {
    _prefs.setString('nombres', value);
  }

  get distrito {
    return _prefs.getString('distrito') ?? 'Bienvenido';
  }

  set distrito(String value) {
    _prefs.setString('distrito', value);
  }
  
  get sentEmail {
    return _prefs.getBool('sentEmail') ?? false;
  }

  set sentEmail(bool value) {
    _prefs.setBool('sentEmail', value);
  }
  
  get telefono {
    return _prefs.getString('telefono') ?? '';
  }

  set telefono(String value) {
    _prefs.setString('telefono', value);
  }

  get departamento {
    return _prefs.getString('departamento') ?? '';
  }

  set departamento(String value) {
    _prefs.setString('departamento', value);
  }
 
}