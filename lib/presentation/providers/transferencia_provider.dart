import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qad_hand_held/domain/entities/transferencia_model.dart';

final transfChangeNotifierProvider =
    ChangeNotifierProvider<TransfChangeNotifier>((ref) {
  return TransfChangeNotifier();
});

class TransfChangeNotifier extends ChangeNotifier {
  List<TransferenciaModel> transf = [];

  void addTransf() {
    transf = [
      ...transf,
      TransferenciaModel(
                dominio: 'aramark',
                articulo: 'Articulo',
                almOrig: 'Planta',
                ubiOrig: 'Ubica',
                lotOrig: 'Lte',
                refOrig: 'Ref',
                almDest: 'Planta',
                ubiDest: 'Ubi01',
                lotDest: 'Lte',
                refDes: 'Ref',
                cantidad: 10),
    ];
    notifyListeners();
  }

 
}
