import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _dominio = '';
  static String _url = '';
  static String _almacen = '';
  static String _ubicTrans = '';
  static String _usuario = '';
  static String _inicio = 'logout';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get dominio {
    return _prefs.getString('dominio') ?? _dominio;
  }

  static set dominio(String dominio) {
    _dominio = dominio;
    _prefs.setString('dominio', dominio);
  }

  static String get url {
    return _prefs.getString('url') ?? _url;
  }

  static set url(String url) {
    _url = url;
    _prefs.setString('url', url);
  }

  static String get almacen {
    return _prefs.getString('almacen') ?? _almacen;
  }

  static set almacen(String almacen) {
    _almacen = almacen;
    _prefs.setString('almacen', almacen);
  }

  static String get ubicTrans {
    return _prefs.getString('ubicTrans') ?? _ubicTrans;
  }

  static set ubicTrans(String ubicTrans) {
    _ubicTrans = ubicTrans;
    _prefs.setString('ubicTrans', ubicTrans);
  }

  static String get usuario {
    return _prefs.getString('usuario') ?? _usuario;
  }

  static set usuario(String usuario) {
    _usuario = usuario;
    _prefs.setString('usuario', usuario);
  }

static String get inicio {
    return _prefs.getString('inicio') ?? _inicio;
  }

  static set inicio(String inicio) {
    _inicio = inicio;
    _prefs.setString('inicio', inicio);
  }

}