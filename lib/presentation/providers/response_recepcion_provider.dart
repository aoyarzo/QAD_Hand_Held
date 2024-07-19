import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/domain/entities/recepcion_oc/recepcion_model.dart';

final responseRecepcionChangeNotifierProvider =
    ChangeNotifierProvider<ResponseRecepcionChangeNotifier>((ref) {
  return ResponseRecepcionChangeNotifier();
});

class ResponseRecepcionChangeNotifier extends ChangeNotifier {
  List<Respuesta> respuesta = [];

  void addRespuesta(String number, String mensaje, String severidad) {
    respuesta = [
      ...respuesta,
      Respuesta(
        number: number, 
        mensaje: mensaje, 
        severidad: severidad),
    ];
    notifyListeners();
  }

  void clearTransf() {
    respuesta.clear();
    notifyListeners();
  }
}