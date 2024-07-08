import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/domain/entities/transferencia_model.dart';
import 'package:qad_hand_held/shared_preferences/preferences.dart';

final transfChangeNotifierProvider =
    ChangeNotifierProvider<TransfChangeNotifier>((ref) {
  return TransfChangeNotifier();
});

class TransfChangeNotifier extends ChangeNotifier {
  List<TransferenciaModel> transf = [];

  void addTransf(String articulo, String ubiOrig, String lotOrig, String refOrig, int cantidad)  {
    transf = [
      ...transf,
      TransferenciaModel(
                dominio: Preferences.dominio,
                articulo: articulo,
                almOrig: Preferences.almacen,
                ubiOrig: ubiOrig,
                lotOrig: lotOrig,
                refOrig: refOrig,
                almDest: '',
                ubiDest: '',
                lotDest: '',
                refDes: refOrig,
                cantidad: cantidad),
    ];
    notifyListeners();
  }

 
}
