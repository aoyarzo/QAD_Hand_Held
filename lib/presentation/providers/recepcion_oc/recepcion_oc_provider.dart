import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/domain/entities/models.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';

final recepcionOCChangeNotifierProvider =
    ChangeNotifierProvider<RecepcionOCChangeNotifier>((ref) {
  return RecepcionOCChangeNotifier();
});

class RecepcionOCChangeNotifier extends ChangeNotifier {
  
  List<RecepcionOcModel> recepcion = [];

  void addRecepcionOC(int idRecepcion, String orden, String proveedor, String efectiva, String documento, String articulo, 
  int linea, double precioFactura, double cantidad, String lote, String referencia, 
  String fechaVenc, ) {
    recepcion = [
      ...recepcion,
      RecepcionOcModel(
        idRecepcion: idRecepcion,
        dominio: Preferences.dominio, 
        orden: orden, 
        proveedor: proveedor, 
        efectiva: efectiva, 
        funda: documento, 
        articulo: articulo, 
        linea: linea, 
        costo: precioFactura, 
        cantidad: cantidad, 
        almacen: Preferences.almacen, 
        ubicacion: Preferences.ubicTrans, 
        lote: lote, 
        referencia: referencia, 
        fchVcto: fechaVenc, 
        usuario: Preferences.usuario)
    ];
    notifyListeners();
  }

  void removeRecepcion(int index) {
    //Crear campo IdRecepcion
    recepcion.removeWhere((item) => item.idRecepcion == index);
    notifyListeners();
  }

  void clearRecepcion() {
    recepcion.clear();
    notifyListeners();
  }
}
