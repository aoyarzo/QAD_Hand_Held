import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/domain/entities/ajuste_inv/ajuste_inv_model.dart';

final responseAjusteInvChangeNotifierProvider =
    ChangeNotifierProvider<ResponseAjusteInvChangeNotifier>((ref) {
  return ResponseAjusteInvChangeNotifier();
});

class ResponseAjusteInvChangeNotifier extends ChangeNotifier {
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

  void clearRespuesta() {
    respuesta.clear();
    notifyListeners();
  }
}