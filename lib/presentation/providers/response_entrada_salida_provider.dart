import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/domain/entities/entrada_salida/entrada_salida_model.dart';

final responseEntradaSalidaNoPlanChangeNotifierProvider =
    ChangeNotifierProvider<ResponseEntradaSalidaNoPlanChangeNotifier>((ref) {
  return ResponseEntradaSalidaNoPlanChangeNotifier();
});

class ResponseEntradaSalidaNoPlanChangeNotifier extends ChangeNotifier {
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