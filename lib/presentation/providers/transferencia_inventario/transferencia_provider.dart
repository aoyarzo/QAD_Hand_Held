import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/domain/entities/transferencia_inventario/transferencia_model.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';

final transfChangeNotifierProvider =
    ChangeNotifierProvider<TransfChangeNotifier>((ref) {
  return TransfChangeNotifier();
});

class TransfChangeNotifier extends ChangeNotifier {
  List<TransferenciaModel> transf = [];

  void addTransf(int linea, String articulo, String ubiOrig, String lotOrig,
      String refOrig, String ubicDest, int cantidad) {
    transf = [
      ...transf,
      TransferenciaModel(
          linea: linea,
          dominio: Preferences.dominio,
          articulo: articulo,
          almOrig: Preferences.almacen,
          ubiOrig: ubiOrig,
          lotOrig: lotOrig,
          refOrig: refOrig,
          almDest: Preferences.almacen,
          ubiDest: ubicDest,
          lotDest: lotOrig,
          refDes: refOrig,
          cantidad: cantidad,
          usuario: 'User001'),
    ];
    notifyListeners();
  }

  void removeTransf(int index) {
    transf.removeWhere((item) => item.linea == index);
    notifyListeners();
  }

  void clearTransf() {
    transf.clear();
    notifyListeners();
  }
}
