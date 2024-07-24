import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/domain/entities/transferencia_inventario/transf_response_model.dart';

final responseTransfChangeNotifierProvider =
    ChangeNotifierProvider<ResponseTransfChangeNotifier>((ref) {
  return ResponseTransfChangeNotifier();
});

class ResponseTransfChangeNotifier extends ChangeNotifier {
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

final responseTransfOrigenProvider = StateProvider<String>((ref) {
  return '';
});

final responseAjusteInvProvider = StateProvider<String>((ref) {
  return '';
});

final responseEntradaNoPlanProvider = StateProvider<String>((ref) {
  return '';
});

final responseSalidaNoPlanProvider = StateProvider<String>((ref) {
  return '';
});
